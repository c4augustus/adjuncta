#!/usr/bin/env python

#   Copyright 2021 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# setup Gentoo installation

# NOTE: Minimal manual steps to get here:
#
#       1. browse https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/current-admincd-amd64
#       2. download admincd-amd64-...(some date)...iso
#       3. burn the .iso file to a USB
#       4. boot the USB
#       5. `mount -o remount,rw /mnt/cdrom`
#       6. `mkdir -p /mnt/cdrom/z/v`
#       7. `chdir /mnt/cdrom/z/v`
#       8. `git clone https://gitlab.com/c4augustus/adjuncta`
#       9. `cd adjuncta/bin/python`

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
    partroot = devtarget + '2'
    sizeboot = '256MiB'
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
        run_shell_command('mkfs.ext4 -L GENBOOT ' + partboot)
    if result.stdout.find('genroot') < 0:
        if not wiped and not ask_ok('CREATE root partition ' + partroot):
            cancel()
        run_shell_command('parted --script ' + devtarget +
                          ' mkpart primary ' + sizeboot + ' 100%')
        run_shell_command('parted --script ' + devtarget +
                          " name 2 'genroot'")
        run_shell_command('mkfs.ext4 -L GENROOT ' + partroot)
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

def acquire_stage3():
    print('...acquiring stage3...')
    print('---------------------------')
    filepath = os.path.dirname(abspath_of_ancestor_dir('v')) + '/u/soft/open/gentoo'
    filename = 'stage3-amd64-20??????T??????Z.tar.xz'
    filere   = '^stage3-amd64-20......T......Z\.tar\.xz$'
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

def establish_stage3(partroot):
    print('...establishing stage3...')
    print('---------------------------')
    pathmount = '/mnt/gentoo'
    run_shell_command('umount ' + pathmount, abort_on_error=False)
    run_shell_command('mount ' + partroot + ' ' + pathmount)
    setdiff = (set(
        ['bin', 'boot', 'dev', 'etc', 'home', 'lib', 'lib64',
        'lost+found', 'media', 'mnt', 'opt', 'proc', 'root',
        'run', 'sbin', 'sys', 'tmp', 'usr', 'var'])
        - set(sorted(os.listdir(pathmount))))
    if (setdiff != set()): 
        print('......missing ' + pathmount + ' subdirectories: ' + str(setdiff))
        print('......extracting stage3...')
        run_shell_command('tar -xpvf ' + acquire_stage3() +
            " --xattrs-include='*.*' --numeric-owner -C, --directory=" + pathmount,
            capture=False)
    run_shell_command('ls -alF ' + pathmount, capture=False)
    print('---------------------------')

def main():
    print('Setup Gentoo installation...')
    check_platform('Linux')
    (partboot, partroot) = establish_partitions()
    establish_stage3(partroot)
    print('...completed setup of Gentoo installation.')

if __name__ == '__main__':
    main()
