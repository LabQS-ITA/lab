# NFS

## Server

```sh
sudo apt install -y nfs-kernel-server autofs
sudo systemctl start nfs-kernel-server.service
sudo systemctl start autofs
```

`/etc/exports`

```
/export       	161.24.23.0/24(rw,async,wdelay,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
```


##  Configurar auto-fs

### Para todos servidores

`/etc/auto.nfs`

```
/import/hom.labqs labqs.ita.br:/export
```

`/etc/auto.master.d/nfs.autofs`

```
/- /etc/auto.nfs
```

### Para servidor de storage

`/etc/auto.nfs`

```
/import/dev.labqs labqs.ita.br:/export
/import/test.labqs labqs.ita.br:/export
/import/ia.labqs labqs.ita.br:/export
```

### Executar após atualização da configuração

```
sudo systemctl reload autofs
```


## Criar sistema de arquivos

Executar o script [setupfs](./fs/setupfs) para cada ambiente.


## Mostrar sistema de arquivos

```
showmount --export
```

```
mount | grep nfs
```