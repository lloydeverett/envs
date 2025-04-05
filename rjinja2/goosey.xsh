from stdgoosey import produce

globals = {
    'shell': {
        'name': 'xonsh',
        'nixpkg': 'xonsh'
    }
}

home = {
    'template': 'home',
    'name': 'my_home'
}
produce(globals, home)

vim_home = {
    'template': 'vim_home',
    'name': 'my_vim_home'
}
produce(globals, vim_home)

podman = {
    'name': 'template',
    'name': 'my_podman'
}
produce(globals, podman)

