# Configuração do Laboratório de Testes de Software

O laboratório de testes concentra ambientes para três fases no fluxo de trabalho do projeto:

* **Desenvolvimento** - livre para os desenvolvedores executarem testes unitários e simulações do desenvolvimento da aplicação
* **Testes** - que com dados anonimizados simula um ambiente de produção para os _Product Owners_ avaliarem o resultado do desenvolvimento, sugerirem melhorias ou modificações
* **Homologação** - também com dados anonimizados onde os clientes do projeto aprovam o produto na sua forma final

Este laboratório é um trablho em andamento e temos ainda uma série de tarefas e serviços que devem ser colocados no ar. 

> O script [setup](./common/setup) deve ser executado na pasta [common](./common) para criar todo o ambiente.

> Temos uma [lista](./TODO.md) de tarefas em andamento.

> Temos também [links](./LINKS.md) úteis com ferramentas e recursos que utilizamos ou pretendemos utilizar.

## Configuração inicial

Obter os fontes:

```bash
git checkout https://github.com/mecita/LTS.git
```

Nas pastas de cada serviço (`mariadb` ou `mongodb` por exemplo) executar o comando [../common/setup](./common/setup) para montar as variáveis de ambiente:

```bash
cd mariadb
```

Será criado um arquivo `.env` com um contendo as senhas a serem utilizadas pelo serviço:

```ini
SVC_PWD_01=fda2896ebab8ebfc9bf9613f
SVC_PWD_02=93df7965e1d76bbdf686342a
SVC_PWD_03=2fb0774931082c4cbfb54267
```

> **ATENÇÃO**: _Caso o arquivo seja regerado, as senhas serão perdidas e o acesso aos serviços pode ser comprometido. Este arquivo **não é salvo no sistema de controle de versões**. Os serviços terão que ser regerados e os dados serão perdidos (o script `cleanup` no diretório do serviço deverá ser executado já que os dados não podem ser acessados com a nova senha). Caso você tenha a senha antiga salva em algum lugar basta restaurar o arquivo `.env` e retomar os acessos - não será necessário regerar os serviços nem apagar os dados._

> **OBSERVAÇÃO**: _Pode ser necessário executar `cleanup` como `sudo`._

Em seguida executar o comando de criação do serviço (ver abaixo).

---

## Comandos úteis

> Estes comandos devem ser executados dentro da pasta de serviços para terem acesso às definições de variáveis de ambiente (arquivo `.env`).

### Módulos comuns a todos os serviços (redes e armazenamento)

Na pasta [`common`](./common) o arquivo [`create.yaml`](./common/create.yaml) contém todas as definições:

```bash
docker-compose -f create.yaml up --detach
```

Este comando irá criar as redes `netlab01`, `netlab02` e `netlab03` que correspondem respectivamente à ambientes de **desenvolvimento**, **testes** e **homologação**, isolados por estas sub-redes:

* `172.1.0.0/16`
* `172.2.0.0/16`
* `172.3.0.0/16`

Na pasta de cada serviço (`mongodb` por exemplo) fazemos o encadeamento com o arquivo [`use.yaml`](./common/use.yaml) com as referências usando a opção `-f` do comando `docker-compose`.

---

### Criar serviços

Use o comando abaixo para criar todos os _containers_ de um determinado serviço. No geral será criado um container para cada ambiente e opcionalmente um _container_ genérico se necessário for.

Os seguintes serviços estão disponíveis:

* [`Artifactory`](artifactory/README.md) - (_Ainda não configurado_)
* [`Backup`](backup/README.md) - (_Ainda não configurado_)
* [`Drone`](drone/README.md)
* [`Gitea`](gitea/README.md)
* [`GitLab`](gitlab/README.md) - (_Inativo_)
* [`GoCD`](gocd/README.md) - (_Inativo_)
* [`HTTPD`](httpd/README.md)
* [`MariaDB`](mariadb/README.md)
* [`MongoDB`](mongodb/README.md)
* [`PostgreSQL`](postgresql/README.md)
* [`Redis`](redis/README.md) - (_Inativo_)

```bash
docker-compose -f stack.yaml -f ../common/use.yaml up --detach
```

### Iniciar serviços

```bash
docker start $(docker container ls -qa)
```

### Parar serviços

```bash
docker stop $(docker container ls -qa)
```

### Apagar todos containers

```bash
docker rm $(docker container ls -qa)
```

### Apagar todos volumes

```bash
docker volume rm $(docker volume ls -q)
```

### Executar os comandos acima para um grupo de serviços específico

```bash
docker start $(docker container ls -qa -f 'name=mongo*')

docker stop $(docker container ls -qa -f 'name=mongo*')

docker rm $(docker container ls -qa -f 'name=mongo*')
```

### Apagar redes do laboratório (não é necessário)

```bash
docker network rm $(docker network ls -f 'name=lab*' -q)
```

---

## Consoles, URLs e arquivos de configuração

---

### Ambientes (desenvolvimento, testes e homologação)

Cada ambiente possui uma instância de cada serviço, numerada (em geral `01` corresponde à desenvolvimento, `02` à testes e `03` à homologação). Instâncias comuns não são numeradas e estão conectadas à todas as redes de todos os ambientes.

#### MongoDB

```bash
bash -c 'docker exec -it mongodb01 bash'
bash -c "docker exec -it mongodb01 mongo mongodb://root:`awk -F'=' '/SVC_PWD_01/{ printf("%s\n",$2) }' .env`@localhost:27017"
```

```bash
curl http://admin:`awk -F'=' '/SVC_PWD_01/{ printf("%s\n",$2) }' .env`@localhost:8081
```

* **Configuração**: [`mongodb01.conf -> /etc/mongod.conf`](mongodb/mongodb01/config/custom.conf)

#### MariaDB

```bash
bash -c 'docker exec -it mariadb01 bash'
bash -c "docker exec -it mariadb01 mysql --user=root --password=`awk -F'=' '/SVC_PWD_01/{ printf("%s\n",$2) }' .env` -P 3306"
```

* **Configuração**: [`mariadb01.cnf -> /etc/mysql/my.cnf`](./mariadb/mariadb01/custom.cnf)

#### PostgreSQL

```bash
bash -c 'docker exec -it postgres01 bash'
bash -c 'docker exec -it postgres01 psql --username=postgres'
```

**Observação**: _O **PostgreSQL** não pede senha para autenticar usuário local_

* **Configuração**: [`postgres01 -> /etc/postgresql`](./postgresql/postgres01)

### Serviços comuns

Estes são "_front-ends_" para os serviços disponíveis nos ambientes. Geralmente é exposta uma página para um portal administrativo do serviço.

> **ATENÇÃO**: Certifique-se de estar sob a pasta `httpd` para executar os comandos abaixo - eles fazem referência relativa à arquivos em outras pastas.

> **OBSERVAÇÃO**: Para acessar o painel AD do MongoDB via _browser_ será necessária a senha que está no arquivo `.env` do ambiente correspondente. Esta senha não está disponível no sistema de controle de versões e pode ser diferente da senha no ambiente do desenvolvedor.

#### GitLab

O GitLab utiliza os serviços comuns `PostgreSQL` e `Redis`.

```bash
bash -c 'docker exec -it gitlab sh'
```

#### Redis

```bash
bash -c 'docker exec -it gitlab sh'
```

#### PostgreSQL (comum)

Além do PostgreSQL comum (utilizado pelo `GitLab` por exemplo), existem instâncias para os diferentes ambientes.

```bash
bash -c 'docker exec -it postgres sh'
```

#### HTTP

Acesso ao console:

```bash
bash -c 'docker exec -it sc bash'
```

O serviço `httpd` serve de _front-end_ para as páginas do `GitLab`, `Adminer` (console para todos bancos de dados), `Commander` (console para o `Redis`).

Acesso às páginas dos serviços:

```bash
lynx -accept_all_cookies localhost:8400
```

* **Configuração**: [`config/ -> /usr/local/apache2/conf`](httpd/panel/config)

## Parâmetros de configuração

Cada serviço possui um arquivo `.env` de configuração. As especificações podem ser vistas em [Parametrização](PARAMETERS.md).
