import time
from locust import HttpUser, task, events

@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--web_path", type=str, env_var="LOCUST_WEB_PATH", default="/locust", help="Locust web path")

class QuickstartUser(HttpUser):

    def on_start(self):
        self.client.instance_path(self.runner.environment.parsed_options.web_path)
        self.client.post("/login", json={"username":"foo", "password":"bar"})