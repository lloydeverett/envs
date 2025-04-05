import os
from stdgoosey import produce

path = os.path.dirname(os.path.abspath(__file__))

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
# produce(globals, home, path)

vim_home = {
    'template': 'vim_home',
    'name': 'my_vim_home'
}
# produce(globals, vim_home, path)

podman = {
    'template': 'podman',
    'name': 'my_podman'
}
# produce(globals, podman, path)

test = {
    'template': '.',
    'hello': 'HELLO YES',
    'world': 'WORLD YES'
}
produce(globals, test, path)

