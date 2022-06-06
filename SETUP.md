# Instalação do Laboratório de Testes de Software

## Requisitos

O Laboratório de Testes de Software roda sob **Linux** (testando com Alpine e Ubuntu) e necessita **Docker** e **Docker Composer** para ser instalado e executado.

## Instalação

Após clonar o repositório contendo o projeto LTS, executar os seguintes comandos:

```shell
cd common
docker-compose -f create.yaml up --detach
./setup
```

---
## Detalhes de instalação dos demais serviços

* [`Adminer`](adminer/README.md)
* [`Artifactory`](artifactory/README.md)
* [`Backup`](backup/README.md) - _Ainda não configurado_
* [`Drone`](drone/README.md)
* [`Gitea`](gitea/README.md)
* [`GitLab`](gitlab/README.md) - _Inativo_
* [`HTTPD`](httpd/README.md)
* [`JupyterLab`](jupyter/README.md)
* [`MariaDB`](mariadb/README.md)
* [`MongoDB`](mongodb/README.md)
* [`PostgreSQL`](postgresql/README.md)
* [`Redis`](redis/README.md) - _Inativo_