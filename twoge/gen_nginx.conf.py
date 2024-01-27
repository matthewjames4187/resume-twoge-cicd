from jinja2 import Environment, FileSystemLoader
import json

terraform_outputs_file = '../terraform_outputs.json'

with open(terraform_outputs_file, 'r') as file:
    terraform_outputs = json.load(file)

server_public_ip = terraform_outputs.get('server_public_ip', '') 
gunicorn_host = "localhost" #modify if decoupled
gunicorn_port = "9876"

env = Environment(loader=FileSystemLoader('templates/'))

template = env.get_template('nginx.conf.j2')

rendered_config = template.render(
    server_public_ip = server_public_ip,
    gunicorn_host=gunicorn_host,
    gunicorn_port=gunicorn_port
)

print(rendered_config)