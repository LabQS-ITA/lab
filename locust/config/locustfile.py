import time
from locust import HttpUser, task

@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--web-path", type=str, env_var="LOCUST_WEB_PATH", default="/locust", help="Locust web path")

class QuickstartUser(HttpUser):

    def on_start(self):
        self.client.post("/locust/login", json={"username":"foo", "password":"bar"})