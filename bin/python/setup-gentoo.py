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
    eprint("SETUP ABORTED: " + reason)
    sys.exit(-1)

def cancel():
    abort("canceled")

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

def check_platform(nameRequired):
    namePlatform = platform.system()
    print("...running on platform " + namePlatform)
    if namePlatform != nameRequired:
        abort("only supported on " + nameRequired)

def run_shell_command(command):
    print("`" + command + "`")
    result = subprocess.run(command, capture_output=True, shell=True, text=True)
    if result.returncode:
        abort(result.stderr)
    return result

def setupHomebrew():
    print("...setting up homebrew...")
    try:
        showBrewConfig()
    except OSError:
        installHomebrew()
        showBrewConfig()
    updateHomebrew()

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

def setup_partitions():
    print("...drive partitions...")
    print("---------------------------")
    wiped = False
    devtarget = "/dev/sda"
    partboot = devtarget + "1"
    partroot = devtarget + "2"
    sizeboot = "256MiB"
    result = run_shell_command("parted " + devtarget + " print")
    if result.stdout.find("Partition Table: gpt") < 0:
        if not wiped and not ask_ok("WIPE and re-partition " + devtarget + " to GPT"):
            cancel()
        run_shell_command("parted --script " + devtarget + " mklabel gpt")
        wiped = True
    if result.stdout.find("genboot") < 0:
        if not wiped and not ask_ok("CREATE boot partition " + partboot):
            cancel()
        run_shell_command("parted --script " + devtarget +
                          " mkpart primary 2048s " + sizeboot)
        run_shell_command("parted --script " + devtarget +
                          " name 1 'genboot'")
        run_shell_command("parted --script " + devtarget +
                          " set 1 boot on")
        run_shell_command("mkfs.ext4 -L GENBOOT " + partboot)
    if result.stdout.find("genroot") < 0:
        if not wiped and not ask_ok("CREATE root partition " + partroot):
            cancel()
        run_shell_command("parted --script " + devtarget +
                          " mkpart primary " + sizeboot + " 100%")
        run_shell_command("parted --script " + devtarget +
                          " name 2 'genroot'")
        run_shell_command("mkfs.ext4 -L GENROOT " + partroot)
        result = run_shell_command("parted " + devtarget + " print")
    result = run_shell_command("parted " + devtarget + " print")
    print(result.stdout)
    print("---------------------------")

def first_file_found_matching(filepath, filename):
    with os.scandir(filepath) as it:
        for entry in it:
            if entry.is_file() and re.fullmatch(filename, entry.name):
                return entry.name
    return ""

def abspath_of_ancestor_dir(name):
    apath = os.path.abspath(".")
    while not not apath and os.path.basename(apath) != name:
        apath = os.path.dirname(apath)
    return apath

def setup_stage3():
    print("...stage3...")
    print("---------------------------")
    filepath = os.path.dirname(abspath_of_ancestor_dir("v")) + "/u/soft/open/gentoo/"
    filename = "stage3-amd64-openrc-*.tar.xz"
    filespec = filepath + filename
    os.makedirs(filepath, mode=755, exist_ok=True)
    filenamefinal = first_file_found_matching(filepath, filename)
    if filenamefinal == "":
        url = "https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/" + filename
        run_shell_command("wget -P " + filepath + " " + url)
        filenamefinal = first_file_found_matching(filepath, filename)
        if filenamefinal == "":
            abort("failed to find or download " + filename)
    print("---------------------------")

def main():
    print("Setup Gentoo installation...")
    check_platform("Linux")
    setup_partitions()
    setup_stage3()
    print("...completed setup of Gentoo installation.")

if __name__ == "__main__":
    main()
