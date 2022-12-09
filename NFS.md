# NFS

## Server

```sh
sudo apt install -y nfs-kernel-server
sudo systemctl start nfs-kernel-server.service
```

`/etc/exports`

```
/export       	161.24.23.0/24(rw,async,wdelay,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
```


## Criar sistema de arquivos

Executar o script [setupfs](./fs/setupfs) para cada ambiente.
