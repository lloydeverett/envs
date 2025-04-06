import os
import json

if __xonsh__.env.get('RJINJA2_PATH') is None or $RJINJA2_PATH == '':
    $RJINJA2_PATH = 'rjinja2'

def produce(globals, env, path):
    template_path = os.path.join(path, env['template'])
    data = { 'globals': globals, 'env': env }
    printf '%s\n' @(json.dumps(data)) | $RJINJA2_PATH @(template_path) '-' --format=json

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

