import time
from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(5, 15)

    @task(5)
    def get_lab_task(self):
        self.client.get('/')

    @task(5)
    def get_lab_git_task(self):
        self.client.get('/git')

    def on_start(self):
        pass