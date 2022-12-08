# NFS

## Server

```sh
sudo apt install -y nfs-kernel-server
sudo systemctl start nfs-kernel-server.service
```

`/etc/exports`

```
/export     *(rw,async,no_subtree_check,no_root_squash)
```


## Criar sistema de arquivos

Executar o script [setupfs](./fs/setupfs) para cada ambiente.
