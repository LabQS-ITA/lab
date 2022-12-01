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

```sh
sudo mkdir -p /export
sudo exportfs -a
```

## Client

```sh
sudo mkdir -p /opt/import/test.labqs.ita.br
sudo mkdir -p /opt/import/dev.labqs.ita.br
sudo mkdir -p /opt/import/labqs.ita.br
```

### Opção temporária linha de comando

```sh
sudo apt install nfs-common
sudo mount dev.labqs.ita.br:/export /opt/import/dev.labqs.ita.br
```

### Opção permanente `fstab`

`/etc/fstab`

```
test.labqs.ita.br:/export /opt/import/test.labqs.ita.br nfs rsize=8192,wsize=8192,timeo=14,intr
dev.labqs.ita.br:/export /opt/import/dev.labqs.ita.br nfs rsize=8192,wsize=8192,timeo=14,intr
labqs.ita.br:/export /opt/import/labqs.ita.br nfs rsize=8192,wsize=8192,timeo=14,intr
```
