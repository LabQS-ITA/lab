# Serviço de controle de versões e integração contínua

## Configurações dos bancos de dados PostgreSQL e Redis

Para instalar o _GitLab_ utilizando os serviços de dados [_PostgreSQL_](../postgresql/README.md) e [_Redis_](../redis/README.md) pré-existentes, após criar o arquivo `.env` (com o comando `../common/buildenv`) será necessário copiar os valores `SVC_PWD` dos arquivos `postgresql/.env` e `redis/.env` dentro de `gitlab/.env`:

* `postgresql/.env` (`SVC_PWD`) --> `gitlab/.env` (`POSTGRES_PWD`)
* `redis/.env` (`SVC_PWD`) --> `gitlab/.env` (`REDIS_PWD`)

O arquivo `.env` para o _GitLab_ deverá ficar assim:

```ini
REDIS_PWD=a4ca6741
POSTGRES_PWD=a650dad9
SVC_PWD=a48a3e94
SVC_PWD_01=2bfb3e56
SVC_PWD_02=f687e22b
SVC_PWD_03=b29365ee
```