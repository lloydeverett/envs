#!/usr/bin/env xonsh

# Unfortunately, devenv doesn't expose any obvious way to expose scripts from
# inside the environment to the outside world. Using 'devenv shell' and specifying
# a subcommand or getting clever with environment variables gets us pretty close,
# but there's still a whole bunch of noise printed to the console. So, here's
# a script that gets around that problem by carefully using file descriptors to
# get only the output we care about.
#
# NOTE:
#   This script requires the devenv in question to handle the $DEVENV_SHELL_CMD
#   and $DEVENV_SHELL_CD environment variables if present when entering the devenv
#   shell by executing $DEVENV_SHELL_CMD in the working directory represented by
#   $DEVENV_SHELL_CD in favour of starting the usual shell session. It'd likely be
#   possible to avoid this requirement via subcommands to 'devenv shell'; we just
#   haven't bothered trying.

import os
import sys

script_path = os.path.abspath(__file__)
script_dir = os.path.dirname(script_path)

if len(sys.argv) < 3 or sys.argv[1] == '-h' or sys.argv[1] == '--help':
    print('usage: devenvx <devenv root> <command> ...' +
          f'\nspecify the devenv root relative to the directory of this script: {script_dir}', file=sys.stderr)
    sys.exit(-1)

arg_devenv_root = sys.argv[1]
arg_command = sys.argv[2]
arg_rest = ' '.join(sys.argv[3:])

out_read_fd, out_write_fd = os.pipe()
out_write_path = f'/proc/{os.getpid()}/fd/{out_write_fd}'
out_read_path = f'/proc/{os.getpid()}/fd/{out_read_fd}'
err_read_fd, err_write_fd = os.pipe()
err_write_path = f'/proc/{os.getpid()}/fd/{err_write_fd}'
err_read_path = f'/proc/{os.getpid()}/fd/{err_read_fd}'

orig_cwd = os.getcwd()

devenv_dir = os.path.join(script_dir, arg_devenv_root)
binary_path = os.path.join(devenv_dir, arg_command)

$DEVENV_SHELL_CMD = f'{binary_path} {arg_rest} > {out_write_path} 2> {err_write_path}'
$DEVENV_SHELL_CD = orig_cwd

cat @(out_read_path) &
cat @(err_read_path) > /dev/stderr &

os.chdir(devenv_dir)

devenv shell /dev/null 2> /dev/null

