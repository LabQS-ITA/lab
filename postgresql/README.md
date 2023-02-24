# Serviço de dados **PostgreSQL** do Laboratório de Testes de Software

O Laboratório de Testes de Software compõe três ambientes (ver [Serviço de administração dos ambientes do Laboratório de Testes de Software](../httpd/README.md)):

1. **Desenvolvimento**
1. **Testes**
1. **Homologação**

Para atender a necessidade arquitetural dos desenvolvedores de aplicações de terem um servidor não-relacional, está disponível um serviço de dados **PostgreSQL**.

## Configuração

Foram criadas instâncias separadas por ambiente (denominadas [postgres01](./postgres01) e [postgres02](./postgres02)). Nas pastas de cada instância temos um arquivo de configuração `config/postgresql.conf` que permite configurar cada instância em particular.

Além disto temos o arquivo `config/pg_hba` onde estão definidos os usuários (como de praxe a senha está no arquivo `.env`):

```
# TYPE    DATABASE    USER        ADDRESS         METHOD  OPTIONS
local     all         postgres                    md5
local     all         all                         md5
host      all         all         localhost       md5
host      all         all         172.1.0.0/16   md5
```

> **OBSERVAÇÃO** A rede IP `172.1.0.0/16` corresponde à sub-rede `netlab01` que pertence ao ambiente de desenvolvimento. Cada sub-rede possui seu próprio endereçamento no Laboratório de Testes e o arquivo deve corresponder à isto. De modo geral os ambientes são segregados e a maioria dos serviços não possui comunicação entre os ambientes.

## Acesso aos serviços **PostgreSQL**

Os serviços não podem ser acessados fora da rede local.

Para administração dos dados é possível se utilizar de um túnel SSH via VPN do ITA:

```sh
ssh -p 2222 -fN -L 5432:172.1.9.201:5432 <usuário VPN ITA>@dev.labqs.ita.br
```

Na rede local é possível acessar diretamente o console de cada serviço por meio da linha de comando:

```sh
bash -c 'docker exec -it postgres01 psql --username=postgres'
```

Onde:
* **postgres01** - é o nome do serviço (para o ambiente de desenvolvimentos neste caso)

A senha do serviço está no arquivo `.env` na pasta do mesmo no servidor, como no exemplo abaixo (que não corresponde à nenhum dos serviços atuais):

```ini
SVC_PWD_01=fda2896ebab8ebfc9bf9613f
SVC_PWD_02=93df7965e1d76bbdf686342a
SVC_PWD_03=2fb0774931082c4cbfb54267
```

O serviço pode ser acessado por máquinas na rede local através do nome (`postgres01` por exemplo), usuário `postgres` e a senha no arquivo `.env`).

> **ATENÇÃO**: Usuários específicos *por aplicação*, assim como bancos de dados específicos *por aplicação* devem ser criados pelo desenvolvedor, que deve evitar utilizar o usuário `postgres` - este usuário existe por comodidade e para permitir ações gerais de administração (como criar bases de dados e novos usuários por exemplo).

## Repositório de dados

Os dados de cada ambiente são mantidos numa pasta com o mesmo nome do serviço, **fora de controle de versão**, e sob um regime de _backup_ automatizado (ver [Serviço de cópias de segurança de dados do Laboratório de Testes de Software](../backup/README.md)).

### Volumes de dados

```bash
mkdir  -p /home/gpes/VOLUMES/docker/volumes/postgresdata03/_data
docker volume create -d local -o type=none -o device="/home/gpes/VOLUMES/docker/volumes/postgresdata03/_data" -o o=bind postgresdata03
```

## Autologin

O usuário `postgres` possui auto-login configurado no arquivo `config/.pgpass` do container correspondente (criado pelo script `common\setup`). Isto permite ao backup rodar via linha de comando sem inserção de senha.
