#!/usr/bin/env python

#   Copyright © 2021 - 2025 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# setup Gentoo installation

# NOTE: Minimal manual steps to get here:
#
#       1. browse https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/current-install-amd64-minimal
#       2. download install-amd64-minimal-...(some datetime)...iso and ...iso.sha256
#       3. validate the iso via: `sha256sum -c ...iso.sha256`
#       4. burn the .iso file to a USB
#       5. boot the USB 2nd partition, 2nd grub entry "Boot LiveCD (kernel: gentoo) (cached)"
#       6. select keymap when prompted (31 for portugal)
#       7. `mkdir /z/v; cd z/v`
#       8. `git clone https://codeberg.org/c4augustus/adjuncta a`
#       9. `cd a/bin/py`
#      10. `./install-gentoo.py`

import os
import platform
import re
import subprocess
import sys

def abort(reason):
    eprint('SETUP ABORTED: '+reason)
    sys.exit(-1)

def cancel():
    abort('canceled')

# from https://stackoverflow.com/questions/5574702/how-to-print-to-stderr-in-python
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# based on https://docs.python.org/2/tutorial/controlflow.html#defining-functions
def ask_ok(prompt, retries=4, complaint='type y/ye/yes or n/no/nop/nope'):
    while True:
        ok = input(prompt+'? (y/n): ')
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise IOError('My give up!')
        print(complaint)

def check_platform(nameRequired):
    namePlatform = platform.system()
    print('...running on platform '+namePlatform)
    if namePlatform != nameRequired:
        abort('only supported on ' +nameRequired)

def run_shell_command(command, capture=True, abort_on_error=True):
    print('`'+command+'`')
    result = subprocess.run(command, capture_output=capture, shell=True, text=True)
    if abort_on_error and result.returncode:
        abort(result.stderr)
    return result

def establish_partitions(devtarget):
    print('----------------------')
    print('...drive partitions...')
    wiped = False
    result = run_shell_command('parted '+devtarget+' print')
    if result.stdout.find('Partition Table: gpt') < 0:
        if not wiped and not ask_ok('WIPE and re-partition '+devtarget+' to GPT'):
            cancel()
        run_shell_command('parted --script '+devtarget+' mklabel gpt')
        wiped = True
        partboot    = '1'
        bootstart   = '2048s'
        bootend     = '1342MB'
        partroot    = '3'
        rootfs      = 'ext4 -L'
    else: ### TODO: HARDCODED to ISO of minimal install, so deduce this instead from the print out
        partboot    = '1'
        bootstart   = '814MB'
        bootend     = '2156MB'
        partroot    = '4'
        rootfs      = 'f2fs -l'
    devboot = devtarget+partboot
    devroot = devtarget+partroot
    if result.stdout.find('genboot') < 0:
        if not wiped and not ask_ok('CREATE boot partition '+partboot):
            cancel()
        run_shell_command('parted --script '+devtarget+
                          ' mkpart primary '+bootstart+' '+bootend)
        run_shell_command('parted --script '+devtarget+
                          " name "+partboot+" 'genboot'")
        run_shell_command('parted --script '+devtarget+
                          ' set ' +partboot+' boot on')
        run_shell_command('mkfs.vfat -n genboot '+devboot)
    if result.stdout.find('genroot') < 0:
        if not wiped and not ask_ok('CREATE root partition '+partroot):
            cancel()
        run_shell_command('parted --script '+devtarget+
                          ' mkpart primary '+bootend+' 100%')
        run_shell_command('parted --script '+devtarget+
                          " name "+partroot+" 'genroot'")
        run_shell_command('mkfs.'+rootfs+' genroot '+devroot)
    result = run_shell_command('parted '+devtarget+' print')
    print(result.stdout)
    return (devboot,devroot)

def first_file_found_matching(filepath, filename):
    with os.scandir(filepath) as it:
        for entry in it:
            if entry.is_file() and re.fullmatch(filename, entry.name):
                return entry.name
    return ''

def abspath_of_ancestor_dir(name):
    apath = os.path.abspath('.')
    while not not apath and os.path.basename(apath) != name:
        apath = os.path.dirname(apath)
    return apath

def acquire_stage3(gentootime):
    print('----------------------')
    print('...acquiring stage3...')
    filepath = os.path.dirname(abspath_of_ancestor_dir('v'))+'/u/soft/open/gentoo'
    ## !!! no longer matching against any time value
    ##filename =  'stage3-amd64-desktop-openrc-'+gentoodate+'T??????Z.tar.xz'
    ##filere   = '^stage3-amd64-desktop-openrc-'+gentoodate+'T......Z\\.tar\\.xz$'
    filename =  'stage3-amd64-desktop-openrc-'+gentootime+'.tar.xz'
    filere   = '^stage3-amd64-desktop-openrc-'+gentootime+'\\.tar\\.xz$'
    filespec = filepath+filename
    os.makedirs(filepath, mode=755, exist_ok=True)
    filenamefinal = first_file_found_matching(filepath, filere)
    if filenamefinal == '':
        site = 'https://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles'
        url = site+'/releases/amd64/autobuilds/'+gentootime+'/'+filename
        run_shell_command('wget -P '+filepath+' '+url, capture=False)
        filenamefinal = first_file_found_matching(filepath, filere)
        if filenamefinal == '':
            abort('failed to find or download '+filename)
    return os.path.join(filepath, filenamefinal)

def mount_installation_root(devroot, pathmount):
    print('--------------------------------')
    print('...mounting installation root...')
    run_shell_command('umount '+pathmount, abort_on_error=False)
    result = run_shell_command('mount '+devroot+' '+pathmount, abort_on_error=False)
    if result.returncode and not 'already mounted' in result.stderr:
        abort(result.stderr)

def establish_stage3(pathmount, gentootime):
    print('---------------------------')
    print('...establishing stage3...')
    setdiff = (set(
        ['bin', 'boot', 'dev', 'etc', 'home', 'lib', 'lib64',
        'media', 'mnt', 'opt', 'proc', 'root',
        'run', 'sbin', 'sys', 'tmp', 'usr', 'var'])
        - set(sorted(os.listdir(pathmount))))
    if setdiff != set():
        print('......missing '+pathmount+' subdirectories: ' + str(setdiff))
        print('......extracting stage3...')
        result = run_shell_command('tar -xpvf ' + acquire_stage3(gentootime) +
            " --xattrs-include='*.*' --numeric-owner -C, --directory="+pathmount,
            capture=False)
        if not result.returncode:
            run_shell_command('cp -av /root/z '+pathmount+'/root', capture=False)
            run_shell_command('ls -alF '+pathmount, capture=False)

def establish_config_file_entry(filespec, key, value):
    entry = f'{key}={value}\n'
    replaced = False
    try:
        with open(filespec, "r") as infile:
            lines = infile.readlines()
        r = re.compile(f'^{key}=.+$')
        for i, line in enumerate(lines):
            if r.match(line):
                if line == entry:
                    return
                else:
                    lines[i] = entry
                    replaced = True
                    break
    except FileNotFoundError:
        print(f'{filespec} not found')
        lines = []
    if not replaced:
        lines.append(entry)
    filespecorig = filespec+'.orig'
    if not os.path.isfile(filespecorig):
        os.rename(filespec, filespecorig)
    with open(filespec, "w") as outfile:
        outfile.writelines(lines)
    print(f'{filespec}: {entry}')

def acquire_portage(pathmount, gentoodate):
    print('-----------------------')
    print('...acquiring portage...')
    filepath = pathmount+'/root/z/u/soft/open/gentoo'
    filename =  'portage-'+gentoodate+'.tar.xz'
    filere   = '^portage-'+gentoodate+'\\.tar\\.xz$'
    filespec = filepath+filename
    os.makedirs(filepath, mode=755, exist_ok=True)
    filenamefinal = first_file_found_matching(filepath, filere)
    if not filenamefinal:
        site = 'https://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/snapshots/'
        url = site + filename
        run_shell_command('wget -P '+filepath+' '+url, capture=False)
        filenamefinal = first_file_found_matching(filepath, filere)
        if filenamefinal == '':
            abort('failed to find or download ' + filename)
    return os.path.join(filepath, filenamefinal)

def configure_etc(pathmount):
    print('----------------------')
    print('...configuring /etc...')
    run_shell_command('echo opinguim >'+pathmount+'/etc/hostname', capture=False)
    establish_config_file_entry(pathmount+'/etc/conf.d/keymaps', 'keymap', '"pt-latin1"')

def prepare_portage(pathmount, gentoodate):
    print('-----------------------')
    print('...preparing portage...')
    pathusr = pathmount+'/usr'
    pathportage = pathusr+'/portage'
    try:
      setdiff = (set(
          ['acct-group', 'acct-user',
          # !!! ignoring all directories in between
          'xfce-base', 'xfce-extra'])
          - set(sorted(os.listdir(pathportage))))
    except FileNotFoundError:
        setdiff = set(['.'])
    if setdiff != set():
        print('......missing '+pathportage+' subdirectories: '+str(setdiff))
        print('......extracting portage...')
        run_shell_command('tar -xpvf ' + acquire_portage(pathmount, gentoodate) +
            " --xattrs-include='*.*' --numeric-owner -C, --directory="+pathusr,
            capture=False)
    run_shell_command('ls '+pathportage, capture=False)
    pathmakeconf = pathmount+'/etc/portage/make.conf'
    establish_config_file_entry(pathmakeconf, 'GENTOO_MIRRORS',
        '"https://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/"')

def perform_chroot(pathmount):
    print('-------------------------')
    print('...establishing chroot...')
    if os.path.isdir(pathmount):
        print('......chrooting to '+pathmount)
        filescriptafter = 'install-gentoo-chroot.py'
        pathscriptafterthis = './'+filescriptafter
        pathscriptafterroot = '/root/'+filescriptafter
        if not os.path.isfile(pathscriptafterthis):
            abort('will not chroot without companion script '+pathscriptafterthis)
        run_shell_command('cp '+pathscriptafterthis
                +' '+pathmount+pathscriptafterroot, capture=False)
        run_shell_command('cp /etc/resolv.conf '+pathmount+'/etc', abort_on_error=False, capture=False)
        run_shell_command('arch-chroot '+pathmount+' '
            ### TODO: WHY DO WE NEED THIS?:
            #+ ' /bin/bash --rcfile <(echo ". /etc/.bashrc; . /etc/profile; export PS1="(chroot) ${PS1}"; python '
            +pathscriptafterroot, capture=False)

def main():
    print('==============================')
    print('Installing Gentoo GNU/Linux...')
    check_platform('Linux')
    gentoodate = '20251130'
    gentootime = gentoodate+'T164554Z'
    pathmount = '/mnt/gentoo'
    (devboot, devroot) = establish_partitions('/dev/sda')
    mount_installation_root(devroot, pathmount)
    establish_stage3(pathmount, gentootime)
    configure_etc(pathmount)
    prepare_portage(pathmount, gentoodate)
    perform_chroot(pathmount)
    print('...completed ENTIRE installation of Gentoo GNU/Linux.')
    print('=====================================================')

if __name__ == '__main__':
    main()
