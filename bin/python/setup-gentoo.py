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

import platform
import re
import subprocess
import sys

def abort(reason):
    eprint("SETUP ABORTED: " + reason)
    sys.exit(-1)

# from https://stackoverflow.com/questions/5574702/how-to-print-to-stderr-in-python
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# based on https://docs.python.org/2/tutorial/controlflow.html#defining-functions
def ask_ok(prompt, retries=4, complaint='type y/ye/yes or n/no/nop/nope'):
    while True:
        ok = input(prompt + "? (y/n): ")
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise IOError('My give up!')
        print(complaint)

# https://stackoverflow.com/questions/12332975/installing-python-module-within-code#15950647
def import_or_ask_to_install(package):
    import importlib
    try:
        globals()[package] = importlib.import_module(package)
    except ImportError:
        if not ask_ok("install python package |" + package + "|? (y/n): "):
            return False
        import pip
        pip.main(["install", package])
        globals()[package] = importlib.import_module(package)
    return True

def checkPlatform(nameRequired):
    namePlatform = platform.system()
    print("...running on platform " + namePlatform)
    if namePlatform != nameRequired:
        abort("only supported on " + nameRequired)

def shellCommand(command):
    print("`" + command + "`")
    return subprocess.call(command, shell=True)

def setupHomebrew():
    print("...setting up homebrew...")
    try:
        showBrewConfig()
    except OSError:
        installHomebrew()
        showBrewConfig()
    updateHomebrew()

def showBrewConfig():
    brewConfig = subprocess.Popen(["brew", "config"],
        stdout=subprocess.PIPE).stdout.read()
    print("......homebrew configuration:")
    print("-----------------------------")
    print(brewConfig)
    print("-----------------------------")

def installHomebrew():
    if not ask_ok("install homebrew"):
        abort("homebrew required")
    print("......installing homebrew...")
    print("----------------------------")
    result = subprocess.call(
        "ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"",
        shell=True)
    print("----------------------------")
    if result:
        abort("failed to install homebrew")

def updateHomebrew():
    print("......updating homebrew...")
    print("----------------------------")
    result = subprocess.call("brew update", shell=True)
    print("----------------------------")
    if result:
        abort("failed to update homebrew")

def setupAnsible():
    listoutput = listAnsible()
    if re.search("ansible", listoutput) is None:
        installAnsible()
        listoutput = listAnsible()
    if re.search("ansible 2.8", listoutput) is None:
        upgradeAnsible(False)

def listAnsible():
    print("......checking ansible versions...")
    listoutput = subprocess.check_output("brew list ansible --versions; exit 0", shell=True)
    print(listoutput)
    return listoutput

def installAnsible():
    print("......installing ansible...")
    print("---------------------------")
    result = subprocess.call("brew install ansible@2.8", shell=True)
    print("---------------------------")
    if result:
        abort("failed to install ansible")

def upgradeAnsible(retrying):
    print("......upgrading ansible...")
    upoutput = subprocess.check_output("brew upgrade ansible@2.8; exit 0",
        stderr=subprocess.STDOUT, shell=True)
    print(upoutput)
    if not retrying and re.search("Xcode alone is not sufficient", upoutput) is not None:
        installXcodeSelect()
        upgradeAnsible(True)

def setupPartitions():
    print("---------------------------")
    deviceTarget = "/dev/sda"
    if not ask_ok("TARGET DEVICE " + deviceTarget):
       abort("canceled setup partitions")
    result = shellCommand("sfdisk --list " + deviceTarget)
    result = shellCommand("parted --script " + deviceTarget + " mklabel gpt")
    result = shellCommand("sfdisk --list " + deviceTarget)
    print("---------------------------")
    if result:
        abort("failed to setup partitions")

def main():
    print("Setup Gentoo installation...")
    checkPlatform("Linux")
    setupPartitions()
    print("...completed setup of Gentoo installation.")

if __name__ == "__main__":
    main()
