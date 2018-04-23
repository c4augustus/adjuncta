#!/usr/bin/env python
# setup Android development environment on macOS [2018.04.22 c4augustus]

from __future__ import print_function
import os
import platform
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

def setupAnsible():
    print("...setting up Ansible...")
    result = subprocess.call("brew list ansible", shell=True)
    if result:
        installAnsible()

def installAnsible():
    print("......installing ansible...")
    print("---------------------------")
    result = subprocess.call("brew install ansible", shell=True)
    print("---------------------------")
    if result:
        abort("failed to install ansible")

def runAnsible():
    print("...running Ansible...")
    os.chdir(sys.path[0] + "/ansible")
    result = subprocess.call(
        "ansible-playbook -i ansible-inventory -vv ansible-dev-android-macos.yml",
        shell=True)

def main():
    print("Setting up Android development environment...")
    checkPlatform()
    setupHomebrew()
    setupAnsible()
    runAnsible()
    print("...completed setup.")

if __name__ == "__main__":
    main()
