#!/usr/bin/env python

#   Copyright © 2025 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# burn ISO to USB

import argparse
import os
import platform
import re
import subprocess
import sys

def abort(reason):
    eprint('ABORTED: '+reason)
    sys.exit(-1)

def cancel():
    abort('canceled')

# from https://stackoverflow.com/questions/5574702/how-to-print-to-stderr-in-python
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

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

def pick_usb_dev():
    result = run_shell_command('diskutil list')
    for line in result.stdout.splitlines():
        if line[:5] == '/dev/':
            pos = line.find(' (external, physical')
            if pos > 6:
                dev = line[:pos]
                print('picking first USB drive: '+line)
                return dev
    abort('no USB drive was found')

def arg_iso_file():
    argparser = argparse.ArgumentParser(description='burn ISO to USB')
    argparser.add_argument('file', metavar='file', help='input ISO file')
    return argparser.parse_args().file

def pick_iso_file():
    files = []
    with os.scandir('.') as it:
        for entry in it:
            if entry.is_file() and re.fullmatch('^.*\\.iso$', entry.name):
                files.append(entry.name)
    if not files: abort('no .iso files found in the current directory')
    for i, file in enumerate(files): print(f'[{i+1}] {file}')
    ### TODO: COMPLETE PICKING A NUMBER
    return '###unknown###'

def burn_iso_to_dev(iso, dev):
    run_shell_command('sudo dd if='+iso+' of='+dev+' bs=1m')
    print('Burned '+iso+' to USB drive '+dev)

def main():
    check_platform('Darwin')
    dev = pick_usb_dev()
    iso = arg_iso_file()
    #iso = pick_iso_file()
    burn_iso_to_dev(iso, dev)

if __name__ == '__main__':
    main()
