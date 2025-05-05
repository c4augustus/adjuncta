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
import pathlib
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

def emerge_missing(exe,package):
    result = run_shell_command('which '+exe, abort_on_error=False)
    if result.stdout:
        print(result.stdout)
    else:
        run_shell_command('emerge '+package, capture=False)

def establish_chrooted(subdirmount):
    print('---------------------------')
    print('...establishing chrooted...')
    if not subdirmount in set(os.listdir('/mnt')):
        run_shell_command('. /etc/profile',               capture=False)
        run_shell_command('export PS1="(chroot) ${PS1}"', capture=False)

def establish_portage(profile):
    print('--------------------------')
    print('...establishing portage...')
    result = run_shell_command('eselect profile show', abort_on_error=False)
    print(result.stdout)
    if result.stderr:
        print(result.stderr)
        run_shell_command('emerge-webrsync 2>out-emerge-webrsync.err', capture=False)
    if not profile in result.stdout:
        run_shell_command('eselect profile set '+profile, capture=False)

def establish_firmware():
    print('---------------------------')
    print('...establishing firmware...')
    fileportpacklicense = '/etc/portage/package.license'
    if not os.path.isfile(fileportpacklicense):
        run_shell_command('echo "sys-kernel/linux-firmware linux-fw-redistributable" >'+fileportpacklicense, capture=False)
        run_shell_command('emerge --ask --noreplace sys-kernel/linux-firmware', capture=False)

def establish_networking():
    print('-----------------------------')
    print('...establishing networking...')
    dirmodulesload = '/etc/modules-load.d'
    if not os.path.isdir(dirmodulesload):
        run_shell_command('mkdir /etc/modules-load.d')
    filemodulesnet = dirmodulesload+'/networking.conf'
    if not os.path.isfile(filemodulesnet):
        run_shell_command('echo iwlwifi >'+filemodulesnet, capture=False)
    emerge_missing('iw','net-wireless/iw')
    result = run_shell_command('which wpa_supplicant', abort_on_error=False)
    if not '/wpa_supplicant' in result.stdout:
        run_shell_command('USE=tkip emerge net-wireless/wpa_supplicant', capture=False)
        run_shell_command('rc-update add wpa_supplication default',      capture=False)
    result = run_shell_command('which dhcpcd', abort_on_error=False)
    if not '/dhcpcd' in result.stdout:
        run_shell_command('emerge net-misc/dhcpcd',         capture=False)
        run_shell_command('rc-update add dhcpcd default',   capture=False)

def establish_grub(devboot):
    print('-----------------------')
    print('...establishing grub...')
    emerge_missing('grub-install','sys-boot/grub')
    run_shell_command('mkdir -p /efi',                         capture=False)
    run_shell_command('mount '+devboot+' /efi',                capture=False)
    if not os.path.isfile('/efi/EFI/gentoo/grubx64.efi'):
        run_shell_command('grub-install --efi-directory=/efi', capture=False)

def establish_kernel():
    print('-------------------------')
    print('...establishing kernel...')
    if not os.path.isfile('/etc/portage/package.use/installkernel'):
        run_shell_command('echo "sys-kernel/installkernel dracut grub" >/etc/portage/package.use/installkernel')
        run_shell_command('emerge sys-kernel/installkernel',     capture=False)
    if not os.path.isfile('/boot/vmlinuz-6.12.58-gentoo-dist'):
        run_shell_command('emerge sys-kernel/gentoo-kernel-bin', capture=False)

def establish_boot(devroot):
    print('-----------------------')
    print('...establishing boot...')
    filegrub = '/boot/grub/grub.cfg'
    if not os.path.isfile(filegrub):
        run_shell_command('ls -alFh /boot',             capture=False)
        run_shell_command('rm -f '+filegrub,            capture=False)
        run_shell_command('grub-mkconfig -o '+filegrub, capture=False)
        print('#########')
        print('### TODO: YOU NEED TO ADD TO grub.cfg ENTRY linux: rootflags=noflush_merge BECAUSE f2fs FAILS WITHOUT IT')
        print('#########')

def establish_essentials():
    print('-----------------------------')
    print('...establishing essentials...')
    emerge_missing('git',     'dev-vcs/git')
    emerge_missing('vim',     'app-editors/vim')
    emerge_missing('ansible', 'app-admin/ansible')

def config_user(diradjuncta, dirhome):
    run_shell_command('cp -v '+diradjuncta+'/config/prog/bash/_copy_to_home/.bash* '+dirhome, capture=False)
    run_shell_command('cp -v '+diradjuncta+'/config/prog/vim/_copy_to_home/.*vim* ' +dirhome, capture=False)
    run_shell_command('passwd', capture=False)

def establish_user_root(subdiradjuncta):
    print('----------------------------')
    print('...establishing user root...')
    config_user('~/'+subdiradjuncta, '~/')

def establish_user(subdiradjuncta,user,userid,groups):
    print('--------------------------------')
    print('...establishing user '+user+'...')
    result = run_shell_command(
        'useradd '+user+' -u '+userid
        +(' -G '+groups if groups else ''), abort_on_error=False)
    if result.stderr and not 'exists' in result.stderr:
        abort(result.stderr)
    dirhome   = '/home/'+user
    dirparent = dirhome+'/'+pathlib.Path(subdiradjuncta).parent.as_posix()
    run_shell_command('mkdir -p '+dirparent,                    capture=False)
    run_shell_command('cp -av ~/'+subdiradjuncta+' '+dirparent, capture=False)
    run_shell_command('chown -R '+user+':'+user+' '+dirhome,    capture=False)
    config_user(dirhome+'/'+subdiradjuncta, dirhome)

def main():
    print('==========================================')
    print('...continuing installation after chroot...')
    check_platform('Linux')
    establish_chrooted('gentoo')
    establish_portage('default/linux/amd64/23.0/desktop')
    establish_firmware()
    establish_networking()
    devboot = '/dev/sda1'
    establish_grub(devboot)
    establish_kernel()
    devroot = '/dev/sda4'
    establish_boot(devroot)
    establish_essentials()
    subdiradjuncta = 'z/v/a'
    establish_user_root(subdiradjuncta)
    establish_user(     subdiradjuncta, 'fazedo', '1111', 'wheel')
    establish_user(     subdiradjuncta, 'humano', '2222', '')
    print('...completed CHROOT setup of Gentoo installation.')

if __name__ == '__main__':
    main()
