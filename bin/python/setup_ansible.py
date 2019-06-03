#!/usr/bin/env python

#   Copyright 2019 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# setup Ansible on macOS

from __future__ import print_function
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
        ok = raw_input(prompt + "? (y/n): ")
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

def checkPlatform():
    if platform.system() != "Darwin":
        abort("only supported on MacOS")

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

def installXcodeSelect():
    # TODO: improve this by not requiring the macOS GUI popup for installation
    # (ref https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line)
    print("......installing Xcode command-line tools...")
    print("---------------------------")
    result = subprocess.call("xcode-select --install", shell=True)
    print("---------------------------")
    if result:
        abort("failed to install Xcode command-line tools")

def main():
    print("Setup Ansible...")
    checkPlatform()
    setupHomebrew()
    setupAnsible()
    print("...completed setup of Ansible.")

if __name__ == "__main__":
    main()
