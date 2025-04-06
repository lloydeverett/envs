#!/usr/bin/env xonsh

$RJINJA2_PATH = './rjinja2'
data = '{ "env": { "world": "HELLO WORLD" } }'
printf '%s\n' @(data) | ./rjinja2 --stdin --command 'cat sample.txt' --silent . - --format=json

