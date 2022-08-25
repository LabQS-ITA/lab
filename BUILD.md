# Passo-a-passo de processo de CI/CD

---

## Criação de chaves de acesso no repositório privado na nuvem (GitHub, GitLab, BitBucket, etc.)

![](./images/01-github-gitea-ssh-key.png)

---

## Criação de token de acesso no repositório de fontes do LabQS

![](./images/02-gitea-ansible-access-token.png)

---

## Sincronizar repositorio de fontes do LabQS com repositório na nuvem

![](./images/03-gitea-repository-mirroring.png)

---

## Registrar o token de acesso ao repositorio de fontes do LabQS no sistema de CM

![](./images/04-ansible-gitea-access-token.png)

---

## Registrar o repositório e ramo do projeto no LabQS

![](./images/05-ansible-repository.png)

---

## Registrar os servidores onde serão feitas as instalações

![](./images/06-ansible-hosts.png)

---

## Modelo de tarefa de CI/CD

![](./images/07-ansible-task-template.png)

---

## Tarefa de construção

![](./images/08-ansible-task-build.png)

---

## Tarefa de instalação

![](./images/09-ansible-task-deploy.png)

---

## Imagem da aplicação criada no servidor

![](./images/10-docker-image.png)

---

## Container da aplicação criado no servidor

![](./images/11-docker-container.png)

---

## Aplicação rodando no servidor

![](./images/12-application.png)

---