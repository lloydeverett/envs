import os
import sys
import subprocess

# Unfortunately, devenv doesn't expose any obvious way to expose scripts from
# inside the environment to the outside world. Using 'devenv shell' and specifying
# a subcommand or getting clear with environment variables gets us pretty close,
# but there's still a whole bunch of noise printed to the console. So, here's
# a script to get around that problem by carefully using pipes to get the output
# we care about.

temp_dir=$(mktemp -d /tmp/out.XXXXXX).strip()

if not temp_dir.startswith('/tmp/out.'):
    sys.exit(-1)

try:
    stdout_fifo = temp_dir + '/stdout'
    stderr_fifo = temp_dir + '/stderr'

    mkfifo @(stdout_fifo)
    mkfifo @(stderr_fifo)

    orig_cwd = os.getcwd()
    script_path = os.path.abspath(__file__)

    script_dir = os.path.dirname(script_path)
    rjinja_dir = os.path.join(script_dir, '../rjinja2/')
    rjinja_path = os.path.join(rjinja_dir, 'rjinja2')

    $DEVENV_SHELL_CMD = f'{rjinja_path} > {stdout_fifo} 2> {stderr_fifo}'
    $DEVENV_SHELL_CD = orig_cwd

    cat @(stdout_fifo) &
    cat @(stderr_fifo) > /dev/stderr &

    os.chdir(rjinja_dir)

    devenv shell /dev/null 2> /dev/null
finally:
    rm -rf @(temp_dir)

