## Setup JupyterHub

1. Criar Dockerfile para container do usuário:
    * Modelo: https://github.com/jupyter/docker-stacks/blob/main/tensorflow-notebook/Dockerfile 
1. Adicionar FROM para cada ambiente (https://github.com/jupyter/jupyter/wiki/Jupyter-kernels):
    * R: https://hub.docker.com/_/r-base/)
        - Instalar o kernelspec: https://irkernel.github.io 
1. Executar build do container do usuário
1. Registrar a imagem no parâmetro `DOCKER_NOTEBOOK_IMAGE` do serviço **JupyterJub**

## Test driver GPU Nvidia

### Criar imagem
```
docker build --tag labqs/gputest:numba --rm --file Dockerfile.test_numba_GPU
docker build --tag labqs/gputest:tensor --rm --file Dockerfile.test_tensor_GPU
```

### Executar teste

```
docker run --rm --gpus all labqs/gputest:numba
docker run --rm --gpus all labqs/gputest:tensor
```