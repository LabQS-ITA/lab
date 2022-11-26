# Serviço de dados **MariaDB/MySQL** do Laboratório de Testes de Software

O Laboratório de Testes de Software compõe três ambientes (ver [Serviço de administração dos ambientes do Laboratório de Testes de Software](../httpd/README.md)):

1. **Desenvolvimento**
1. **Testes**
1. **Homologação**

Para atender a necessidade arquitetural dos desenvolvedores de aplicações de terem um servidor relacional, está disponível um serviço de dados **MariaDB** (que é um banco de dados relacional derivado do projeto **MySQL**, e por questões de licenciamento optamos por utilizar aquele em detrimento deste).

## Configuração

Foram criadas instâncias separadas por ambiente (denominadas [mariadb01](./mariadb01) e [mariadb02](./mariadb02). Nas pastas de cada instância temos um arquivo de configuração [custom.cnf](./mariadb02) e [mariadb01](./mariadb01/custom.cnf) que permite configurar cada instância em particular.

## Acesso aos serviços **MariaDB**

Os serviços não podem ser acessados fora da rede local.

Para administração dos dados é possível se utilizar de um túnel SSH via VPN do ITA:

```sh
ssh -p 2222 -fN -L 3306:172.1.9.201:3306 <usuário VPN ITA>@dev.labqs.ita.br
```

Na rede local é possível acessar diretamente o console de cada serviço por meio da linha de comando:

```sh
bash -c "docker exec -it mysql01 mysql --user=root --password=`awk -F'=' '/SVC_PWD_01/{ printf("%s\n",$2) }' .env` -P 3306"
```

Onde:
* **mariadb01** - é o nome do serviço (para o ambiente de desenvolvimentos neste caso)
* **SVC_PWD_01** - é a senha no arquivo `.env` que corresponde à este serviço particular

> **OBSERVAÇÃO**: Este comando em linha só funciona dentro da pasta do serviço (para acessar o arquivo `.env`)

A senha do serviço está no arquivo `.env` na pasta do mesmo no servidor, como no exemplo abaixo (que não corresponde à nenhum dos serviços atuais):

```ini
SVC_PWD_01=fda2896ebab8ebfc9bf9613f
SVC_PWD_02=93df7965e1d76bbdf686342a
```

O serviço pode ser acessado por máquinas na rede local através do nome (`mariadb01` por exemplo), usuário `root` e a senha no arquivo `.env`).

> **ATENÇÃO**: Usuários específicos *por aplicação*, assim como bancos de dados específicos *por aplicação* devem ser criados pelo desenvolvedor, que deve evitar utilizar o usuário `root` - este usuário existe por comodidade e para permitir ações gerais de administração (como criar bases de dados e novos usuários por exemplo).

## Repositório de dados

Os dados de cada ambiente são mantidos numa pasta com o mesmo nome do serviço, **fora de controle de versão**, e sob um regime de _backup_ automatizado (ver [Serviço de cópias de segurança de dados do Laboratório de Testes de Software](../backup/README.md)).

## Autologin

O usuário `maint` possui auto-login configurado na pasta `config` do container correspondente (criado pelo script `common\setup`). Isto permite ao backup rodar via linha de comando sem inserção de senha.