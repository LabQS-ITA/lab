# Pasta de imagens docker

Editar `/etc/docker/daemon.json`:

```json
{
    "data-root": "/novo/caminho/para/imagens-docker"
}
```

Reiniciar o serviço:

```sh
sudo systemctl daemon-reload
sudo systemctl restart docker
```