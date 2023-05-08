# Instalação do sistema de arquivos


## Instalar NFS

Seguir as instruções em [NFS](./NFS.md).


## Instalar AutoFS

```sh
sudo apt-get install autofs -y
```

## Configuração

Criar o arquivo `/etc/auto.master.d/nfs.autofs`:

```
/- /etc/auto.nfs
```

> **Obs**.: o conteúdo é o mesmo para qualquer servidor.

Criar o arquivo `/etc/auto.nfs`.

> **Obs**.: cada ambiente possui um arquivo diferente.

### Teste

```
/import/dev.labqs dev.labqs.ita.br:/export
/import/hom.labqs labqs.ita.br:/export
```

### Desenvolvimento

```
/import/tst.labqs test.labqs.ita.br:/export
/import/hom.labqs labqs.ita.br:/export
```

### Homologação

```
/import/dev.labqs dev.labqs.ita.br:/export
/import/tst.labqs test.labqs.ita.br:/export
```

## Re-iniciar o serviço AutoFS

```
sudo systemctl restart autofs
```

> **Obs**.: verificar conteúdo da pasta `/import` - deverão ser criados sub-pastas com os nomes dos ambientes, tal como `dev.labqs`, e dentro desta estarão os arquivos criados pelo script `setupfs` (ver [NFS](./NFS.md)).
