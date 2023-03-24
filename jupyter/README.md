## Setup JupyterHub

1. Criar Dockerfile para container do usuário:
    * Modelo: https://github.com/jupyter/docker-stacks/blob/main/tensorflow-notebook/Dockerfile 
1. Adicionar FROM docker.io/para cada ambiente (https://github.com/jupyter/jupyter/wiki/Jupyter-kernels):
    * R: https://hub.docker.com/_/r-base/)
        - Instalar o kernelspec: https://irkernel.github.io 
1. Executar build do container do usuário
1. Registrar a imagem no parâmetro `DOCKER_NOTEBOOK_IMAGE` do serviço **JupyterJub**

### Criar grupos de usuários por projeto

Por exemplo:

```sh
groupadd -f proj
```

### Criar usuários para acessar o ambiente Jupyter e colocá-lo nos grupos

```sh
adduser --disabled-password --gecos "" novousr
usermod -a -G users novousr
usermod -a -G proj novousr
```

### Modificar a configuração do Jupyter para incluir o novo grupo

Por exemplo, para mapear uma pasta compartilhada:

```python
proj = [g.gr_mem for g in grp.getgrall() if g.gr_name == 'proj'][0]

 .  .  .

 def config_by_user(spawner):
    username = spawner.user.name
    if username in proj:
        spawner.volumes = { 
            'jupyterhub-user-{username}': notebook_dir,
            'jupyterdata': {"bind": '/home/jovyan/work/data', "mode": "ro"},
        }

c.DockerSpawner.pre_spawn_hook = config_by_user

```