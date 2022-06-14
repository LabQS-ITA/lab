import time
from locust import HttpUser, task

class QuickstartUser(HttpUser):

    def on_start(self):
        self.client.post("/login", json={"username":"maint", "password":"p4ssw0rd"})