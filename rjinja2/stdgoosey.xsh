import json
import os

script_path = os.path.dirname(os.path.abspath(__file__))
rjinja2_path = os.path.join(script_path, 'rjinja2')

def produce(globals, env, path):
    template_path = os.path.join(path, env['template'])
    data = { 'globals': globals, 'env': env }
    printf '%s\n' @(json.dumps(data)) | @(rjinja2_path) @(template_path) '-' --format=json

