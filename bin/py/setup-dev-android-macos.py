#!/usr/bin/env python

#   Copyright 2019 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# setup Android development environment on macOS

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
    print("Setup development environment...")
    setup_ansible.checkPlatform()
    setup_ansible.main()
    runAnsible()
    print("...completed setup of development environment.")

if __name__ == "__main__":
    main()
