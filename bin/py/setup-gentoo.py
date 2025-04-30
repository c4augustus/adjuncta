#!/usr/bin/env python

#   Copyright © 2021 - 2025 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# setup Gentoo installation

# NOTE: Minimal manual steps to get here:
#
#       1. browse https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/current-admincd-amd64
#       2. download admincd-amd64-desktop-openrc-...(some date)...iso and iso.sha256
#       3. validate the iso via: `sha256sum -c ...iso.sha256`
#       4. burn the .iso file to a USB
#       5. boot the USB
#       6. `mount -o remount,rw /mnt/cdrom`
#       7. `mkdir -p /mnt/cdrom/z/v`
#       8. `chdir /mnt/cdrom/z/v`
#       9. `git clone https://gitlab.com/c4augustus/adjuncta`
#       10. `cd adjuncta/bin/python`

import os
import platform
import re
import subprocess
import sys

def abort(reason):
    eprint('SETUP ABORTED: ' + reason)
    sys.exit(-1)

def cancel():
    abort('canceled')

# from https://stackoverflow.com/questions/5574702/how-to-print-to-stderr-in-python
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# based on https://docs.python.org/2/tutorial/controlflow.html#defining-functions
def ask_ok(prompt, retries=4, complaint='type y/ye/yes or n/no/nop/nope'):
    while True:
        ok = input(prompt + '? (y/n): ')
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
    print('...running on platform ' + namePlatform)
    if namePlatform != nameRequired:
        abort('only supported on ' + nameRequired)

def run_shell_command(command, capture=True, abort_on_error=True):
    print('`' + command + '`')
    result = subprocess.run(command, capture_output=capture, shell=True, text=True)
    if abort_on_error and result.returncode:
        abort(result.stderr)
    return result

def establish_partitions():
    print('...drive partitions...')
    print('---------------------------')
    wiped = False
    devtarget = '/dev/sda'
    partboot = devtarget + '1'
    partroot = devtarget + '3'
    sizeboot = '1342MB'
    result = run_shell_command('parted ' + devtarget + ' print')
    if result.stdout.find('Partition Table: gpt') < 0:
        if not wiped and not ask_ok('WIPE and re-partition ' + devtarget + ' to GPT'):
            cancel()
        run_shell_command('parted --script ' + devtarget + ' mklabel gpt')
        wiped = True
    if result.stdout.find('genboot') < 0:
        if not wiped and not ask_ok('CREATE boot partition ' + partboot):
            cancel()
        run_shell_command('parted --script ' + devtarget +
                          ' mkpart primary 2048s ' + sizeboot)
        run_shell_command('parted --script ' + devtarget +
                          " name 1 'genboot'")
        run_shell_command('parted --script ' + devtarget +
                          ' set 1 boot on')
        run_shell_command('mkfs.vfat -n GENBOOT ' + partboot)
    if result.stdout.find('genroot') < 0:
        if not wiped and not ask_ok('CREATE root partition ' + partroot):
            cancel()
        run_shell_command('parted --script ' + devtarget +
                          ' mkpart primary ' + sizeboot + ' 100%')
        run_shell_command('parted --script ' + devtarget +
                          " name 3 'genroot'")
        run_shell_command('mkfs.f2fs -n GENROOT ' + partroot)
        result = run_shell_command('parted ' + devtarget + ' print')
    result = run_shell_command('parted ' + devtarget + ' print')
    print(result.stdout)
    print('---------------------------')
    return (partboot,partroot)

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

def acquire_stage3(gentoodate):
    print('...acquiring stage3...')
    print('---------------------------')
    filepath = os.path.dirname(abspath_of_ancestor_dir('v')) + '/u/soft/open/gentoo'
    filename = 'stage3-amd64-desktop-openrc-' + gentoodate + 'T??????Z.tar.xz'
    filere   = '^stage3-amd64-desktop-openrc-' + gentoodate + 'T......Z\.tar\.xz$'
    filespec = filepath + filename
    os.makedirs(filepath, mode=755, exist_ok=True)
    filenamefinal = first_file_found_matching(filepath, filere)
    if filenamefinal == '':
        site = 'ftp://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles'
        url = site + '/releases/amd64/autobuilds/current-stage3-amd64/' + filename
        run_shell_command('wget -P ' + filepath + ' ' + url)
        filenamefinal = first_file_found_matching(filepath, filere)
        if filenamefinal == '':
            abort('failed to find or download ' + filename)
    print('---------------------------')
    return os.path.join(filepath, filenamefinal)

def establish_stage3(partroot, pathmount, gentoodate):
    print('...establishing stage3...')
    print('---------------------------')
    run_shell_command('umount ' + pathmount, abort_on_error=False)
    result = run_shell_command('mount ' + partroot + ' ' + pathmount, abort_on_error=False)
    if result.returncode and not 'already mounted' in result.stderr:
        abort(result.stderr)
    setdiff = (set(
        ['bin', 'boot', 'dev', 'etc', 'home', 'lib', 'lib64',
        'media', 'mnt', 'opt', 'proc', 'root',
        'run', 'sbin', 'sys', 'tmp', 'usr', 'var'])
        - set(sorted(os.listdir(pathmount))))
    if setdiff != set():
        print('......missing ' + pathmount + ' subdirectories: ' + str(setdiff))
        print('......extracting stage3...')
        run_shell_command('tar -xpvf ' + acquire_stage3(gentoodate) +
            " --xattrs-include='*.*' --numeric-owner -C, --directory=" + pathmount,
            capture=False)
    run_shell_command('ls -alF ' + pathmount, capture=False)
    print('---------------------------')

def establish_config_file_entry(filespec, key, value):
    entry = f'{key}={value}'
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
    filespecorig = filespec + '.orig'
    if not os.path.isfile(filespecorig):
        os.rename(filespec, filespecorig)
    with open(filespec, "w") as outfile:
        outfile.writelines(lines)
    print(f'{filespec}: {entry}')

def acquire_portage(gentoodate):
    print('...acquiring portage...')
    print('-----------------------')
    filepath = os.path.dirname(abspath_of_ancestor_dir('v')) + '/u/soft/open/gentoo'
    filename = 'portage-' + gentoodate + '.tar.xz'
    filere   = '^portage-' + gentoodate + '\.tar\.xz$'
    filespec = filepath + filename
    os.makedirs(filepath, mode=755, exist_ok=True)
    filenamefinal = first_file_found_matching(filepath, filere)
    if filenamefinal == '':
        site = 'ftp://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles'
        url = site + '/releases/amd64/autobuilds/current-stage3-amd64/' + filename
        run_shell_command('wget -P ' + filepath + ' ' + url)
        filenamefinal = first_file_found_matching(filepath, filere)
        if filenamefinal == '':
            abort('failed to find or download ' + filename)
    print('-----------------------')
    return os.path.join(filepath, filenamefinal)

def prepare_portage(pathmount, gentoodate):
    print('...preparing portage...')
    print('-----------------------')
    pathusr = pathmount + '/usr'
    pathportage = pathusr + '/portage'
    try:
      setdiff = (set(
          ['acct-group', 'acct-user',
          # !!! ignoring all directories in between
          'xfce-base', 'xfce-extra'])
          - set(sorted(os.listdir(pathportage))))
    except FileNotFoundError:
        setdiff = set(['.'])
    if setdiff != set():
        print('......missing ' + pathportage + ' subdirectories: ' + str(setdiff))
        print('......extracting portage...')
        run_shell_command('tar -xpvf ' + acquire_portage(gentoodate) +
            " --xattrs-include='*.*' --numeric-owner -C, --directory=" + pathusr,
            capture=False)
    run_shell_command('ls ' + pathportage, capture=False)
    pathmakeconf = pathmount + '/etc/portage/make.conf'
    establish_config_file_entry(pathmakeconf, 'GENTOO_MIRRORS',
        #ftp://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/ \
        #http://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/ \
        '"https://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/"')
        #rsync://ftp.rnl.tecnico.ulisboa.pt/pub/gentoo/gentoo-distfiles/ \
        #rsync://umbriel.br.ext.planetunix.net/gentoo/"
    print('-----------------------')

def perform_chroot(dirmount):
    print('...establishing chroot...')
    print('-------------------------')
    if dirmount in set(os.listdir('/mnt')):
        pathmount = '/mnt/' + dirmount
        print('......chrooting to '+ pathmount)
        ## !!! arch-chroot does this:
        ##fileresolv = 'resolv.conf'
        ##if not fileresolv in os.listdir(pathmount + '/etc'):
        ##    pathresolv = '/etc/' + fileresolv
        ##    run_shell_command('cp ' + pathresolv + ' ' + pathmount + pathresolv, capture=False)
        filescriptafter = 'setup-gentoo-chroot.py'
        pathscriptafterthis = './' + filescriptafter
        pathscriptafterroot = '/root/' + filescriptafter
        if not os.path.isfile(pathscriptafterthis):
            abort('will not chroot without companion script ' + pathscriptafterthis)
        ##if not os.path.isfile(pathscriptafterroot):
        run_shell_command('cp ' + pathscriptafterthis
                + ' ' + pathmount + pathscriptafterroot, capture=False)
        run_shell_command('cp /etc/resolv.conf '+pathmount+'/etc', capture=False)
        run_shell_command('arch-chroot '+pathmount+' '
            ### TODO: WHY DO WE NEED THIS?:
            #+ ' /bin/bash --rcfile <(echo ". /etc/.bashrc; . /etc/profile; export PS1="(chroot) ${PS1}"; python '
            + pathscriptafterroot, capture=False)
    print('-------------------------')

def main():
    print('Setup Gentoo installation...')
    print('============================')
    check_platform('Linux')
    gentoodate = '20251130'
    dirmount = 'gentoo'
    pathmount = '/mnt/' + dirmount
    (partboot, partroot) = establish_partitions()
    establish_stage3(partroot, pathmount, gentoodate)
    prepare_portage(pathmount, gentoodate)
    perform_chroot(dirmount)
    print('=================================================')
    print('...completed ENTIRE setup of Gentoo installation.')

if __name__ == '__main__':
    main()
