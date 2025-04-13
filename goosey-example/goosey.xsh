import os
import json

# we want the code here to tend towards something that becomes declarative, i.e. not xonsh --
# something we can run in a browser with pyodide; let's factor out logic into subroutines
# accordingly as and when it makes sense

def produce(globals, env):
    template_path = os.path.join('.', env['template'])
    data = { 'globals': globals, 'env': env }
    printf '%s\n' @(json.dumps(data)) | rjinja2 @(template_path) '-' --format=json

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
# produce(globals, home)

vim_home = {
    'template': 'vim_home',
    'name': 'my_vim_home'
}
# produce(globals, vim_home)
 
podman = {
    'template': 'podman',
    'name': 'my_podman'
}
# produce(globals, podman)

test = {
    'template': '.',
    'hello': 'HELLO YES',
    'world': 'WORLD YES'
}
produce(globals, test)

