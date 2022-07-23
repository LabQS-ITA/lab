# Configuração do `sshfs` para os servidores do Laboratório

## Sistema de arquivos

Pasta de arquivos que serão compartilhados *para* os servidores _externos_:

```
~/shared/out
```

Pastas dos servidores externos que serão compartilhados *para* o servidor _local_:

```
~/shared/in/<designação do servidor externo [test | dev | hom]>
```

Arquivo `fstab` para inicializar as pastas compartilhadas no boot:

```
# ...
# SSHFS LabQS
# TEST
sshfs#gpes@161.24.23.94:/home/gpes/shared/out /home/gpes/shared/in/test fuse defaults,allow_other 0 0
# DEV
sshfs#gpes@161.24.23.95:/home/gpes/shared/out /home/gpes/shared/in/dev fuse defaults,allow_other 0 0
# HOM
sshfs#gpes@161.24.23.96:/home/gpes/shared/out /home/gpes/shared/in/hom fuse defaults,allow_other 0 0
```