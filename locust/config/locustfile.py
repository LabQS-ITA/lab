import time
from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(5, 15)

    @task(5)
    def get_lab_task(self):
        self.client.get('/')

    @task(5)
    def get_lab_adminer_task(self):
        self.client.get('/adminer')

    @task(5)
    def get_lab_git_task(self):
        self.client.get('/git')

    @task(5)
    def get_lab_commander_task(self):
        self.client.get('/commander')

    def on_start(self):
        pass