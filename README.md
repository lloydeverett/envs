
# envs

## Usage

Make sure [devenv](https://devenv.sh/getting-started/) is installed. Then you can hop into a shell via e.g.

```bash
cd home
devenv shell
```

## Environments

 - `home` - shell and editor environment focused on xonsh and vim
 - `podman-example` - an experiment in running rootless and daemonless containers inside a devenv (see associated README, there are some prerequisites for the host OS)
 - `rjinja2` - an implementation of a tool that calls `jinja2` recursively

## Environment Templates

These will generally require the `bin` directory to be on the `PATH`.

 - `goosey-example` - some experimenting with possible uses `rjinja2` to template out environments

## `./bin`

This directory defines wrappers used to expose tools defined in the environments above to the outside world (i.e. your host system shell, and other unrelated devenv environments).

 - `devenvx` - execute an arbitrary binary or script accessible within a devenv from the outside world
 - `rjinja2` - wraps `envs/rjinja2/rjinja2` using devenvx

### Setup

You will need to install `xonsh` using the host package manager to be able to run the wrapper scripts. For example, on Debian-based distros:

```sh
sudo apt-get install xonsh
```

Then, to make these wrappers available on the `PATH`, use something like:

**sh-like syntax**

```sh
export PATH="$PATH:$(realpath ~/envs/bin)"
```

**xonsh syntax**

```xonsh
$PATH.append($(realpath '~/envs/bin').strip())
```

## `./dotfiles`

A place for my shell environment preferences.


