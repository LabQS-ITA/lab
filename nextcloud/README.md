# Migração dos dados para gerenciador de armazenamento

## Nextcloud

```sh
docker stop nextcloud
docker rm nextcloud
```

## Postgres

```sql
ALTER DATABASE nextcloud RENAME TO nextcloud_old;
CREATE DATABASE nextcloud;
ALTER DATABASE nextcloud OWNER TO nextcloud;
```

## Recriar container Nextcloud

```sh
./nextcloud dev
```


