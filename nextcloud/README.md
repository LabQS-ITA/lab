# Migração dos dados para gerenciador de armazenamento

```sh
cd . . . docker/volumes/flualfadata/_data/
mc cp --recursive documents/* st-test-maint/flualfa/public/documents
```

## Atualização dos índices

```sh
apt update
apt install sudo -y
sudo -u www-data php /var/www/html/occ files:scan --all


![](../images/st/flualfa-migracao.png)
