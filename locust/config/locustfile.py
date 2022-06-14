import time
from locust import HttpUser, task, between

class Dummy(HttpUser):
    wait_time = between(1, 5)

    @task
    def hello_world(self):
        self.client.get("/hello")
        self.client.get("/world")

    def on_start(self):
        self.client.post("/", json={"dummy":"dummy"})