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

from __future__ import print_function
import os
import setup_ansible
import subprocess
import sys

def runAnsible():
    print("...running Ansible...")
    os.chdir(sys.path[0] + "/ansible")
    result = subprocess.call(
        "ansible-playbook -i ansible-inventory -vv ansible-dev-android-macos.yml",
        shell=True)

def main():
    print("Setup Gentoo installation...")
    setup_ansible.checkPlatform()
    setup_ansible.main()
    runAnsible()
    print("...completed setup of development environment.")

if __name__ == "__main__":
    main()
