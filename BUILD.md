# Passo-a-passo de processo de CI/CD

---

## Repositório de fontes LabQS

![](./images/0100-gitea.png)

---

## Criação de chaves de acesso no repositório privado na nuvem (GitHub, GitLab, BitBucket, etc.)

![](./images/0110-github-gitea-ssh-key.png)

---

## Criação de token de acesso no repositório de fontes do LabQS

![](./images/0120-gitea-ansible-access-token.png)

---

## Sincronizar repositorio de fontes do LabQS com repositório na nuvem

![](./images/0130-gitea-repository-mirroring.png)

---

## Gerenciamento de configurações

![](./images/0135-ansible.png)

---

## Registrar o token de acesso ao repositorio de fontes do LabQS no sistema de CM

![](./images/0140-ansible-gitea-access-token.png)

---

## Registrar o repositório e ramo do projeto no LabQS

![](./images/0150-ansible-repository.png)

---

## Registrar os servidores onde serão feitas as instalações

![](./images/0160-ansible-hosts.png)

---

## Modelo de tarefa de CI/CD

![](./images/0170-ansible-task-template.png)

---

## Tarefa de construção

![](./images/0180-ansible-task-build.png)

---

## Tarefa de instalação

![](./images/0190-ansible-task-deploy.png)

---

## Gerenciador de serviços

![](./images/0195-portainer.png)

---

## Imagem da aplicação criada no servidor

![](./images/0200-docker-image.png)

---

## Container da aplicação criado no servidor

![](./images/0210-docker-container.png)

---

## Aplicação rodando no servidor

![](./images/0220-application.png)

---

## Gerenciador de integração

![](./images/0225-drone.png)

---

## Instalação da aplicação na integração

![](./images/0230-drone-install.png)

---

## Teste da aplicação na integração

![](./images/0240-drone-teste.png)

---