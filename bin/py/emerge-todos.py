#!/usr/bin/env python

#   Copyright © 2021 - 2025 Christopher Augustus
#
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.

# continue setup Gentoo installation after chroot

import platform
import subprocess
import sys

def abort(reason):
    eprint('SETUP ABORTED: ' + reason)
    sys.exit(-1)

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

def emerge_missing(exe, package, use):
    result = run_shell_command('which '+exe, abort_on_error=False)
    if result.stdout:
        print(result.stdout)
    else:
        run_shell_command('USE="'+use+'" emerge '+package, capture=False)

## TODO: FOR POSTERITY: could not figure out how to scale 4k using Wayland
def emerge_qtile():
    emerge_missing('qtile', 'x11-wm/qtile')
    dirconfig = '~/.config/qtile'
    run_shell_command('mkdir -p '+dirconfig)
    run_shell_command(
        'cp /usr/lib/python3.13/site-packages/libqtile/resources/default_config.py '
        +dirconfig+'/config.py')

def emerge_sway():
    emerge_missing('sway', 'gui-wm/sway')
    ## NOTE: config file defaults to '/etc/sway/config'
    ## but we are setting our XDG_CONFIG_HOME=$ADUNCTA_DIR/conf/xdg
    ## which will already have my current personal defaults

def main():
    check_platform('Linux')
    emerge_missing_sway()

if __name__ == '__main__':
    main()
