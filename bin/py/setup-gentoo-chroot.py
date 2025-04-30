#!/usr/bin/env python

#   Copyright © 2021 - 2025 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# continue setup Gentoo installation after chroot

# NOTE: this should only need to be called from setup-gentoo.py

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

def establish_chrooted(subdirmount):
    print('...establishing chrooted...')
    print('-------------------------')
    if not subdirmount in set(os.listdir('/mnt')):
        run_shell_command('. /etc/profile',               capture=False)
        run_shell_command('export PS1="(chroot) ${PS1}"', capture=False)
    print('-------------------------')

def establish_portage(profile):
    print('...establishing portage...')
    print('--------------------------')
    result = run_shell_command('eselect profile show', abort_on_error=False)
    print(result.stdout)
    if result.stderr:
        print(result.stderr)
        run_shell_command('emerge-webrsync 2>out-emerge-webrsync.err', capture=False)
    if not profile in result.stdout:
        run_shell_command('eselect profile set '+profile, capture=False)
    print('--------------------------')

def establish_grub():
    print('...establishing grub...')
    print('-----------------------')
    result = run_shell_command('which grub-install', abort_on_error=False)
    if not '/grub-install' in result.stdout:
        run_shell_command('emerge sys-boot/grub', capture=False)
    print('-----------------------')

def establish_boot(devboot, dirboot):
    print('...establishing boot...')
    print('-----------------------')
    run_shell_command('mkdir -p '                    +dirboot,     capture=False)
    result = run_shell_command('mount')
    if                             devboot+' on '    +dirboot in result.stdout:
        run_shell_command('mount '+devboot+' '       +dirboot,     capture=False)
    run_shell_command('grub-install --efi-directory='+dirboot,     capture=False)
    run_shell_command('ls -alF '                     +dirboot,     capture=False)
    print('-----------------------')

def main():
    print('==========================================')
    print('...continuing installation after chroot...')
    print('==========================================')
    check_platform('Linux')
    establish_chrooted('gentoo')
    establish_portage('default/linux/amd64/23.0/desktop')
    establish_grub()
    #devboot = '/dev/sda1'
    #dirboot = '/efi'
    #establish_boot(devboot, dirboot)
    print('=================================================')
    print('...completed CHROOT setup of Gentoo installation.')

if __name__ == '__main__':
    main()
