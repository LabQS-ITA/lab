# Como utilizar os servidores do laboratório

## Via linha de comando

Uma vez conectada à VPN do laboratório, é possível usar um túnel SSH para acessar os serviços do laboratório, como os de bancos de dados por exemplo:

### Postgres
```sh
ssh -fN -L 5432:172.1.2.201:5432 <usuario da vpn>@dev.labqs.ita.br -p 2222
```

### Redis
```sh
ssh -fN -L 6379:172.1.7.201:6379 <usuario da vpn>@dev.labqs.ita.br -p 2222
```

### MongoDB
```sh
ssh -fN -L 27017:172.1.8.201:27017 <usuario da vpn>@dev.labqs.ita.br -p 2222
```

### MariaDB
```sh
ssh -fN -L 3306:172.1.9.201:3306 <usuario da vpn>@dev.labqs.ita.br -p 2222
```

Uma vez conectado o túnel SSH podemos conectar o serviço remoto como se estivesse instalado localmente. Por exemplo, abrir a conexão com servidor Postgres tunelado acima:

```sh
telnet localhost 5432
Trying ::1...
Connected to localhost.
Escape character is '^]'.
^]
telnet> quit
Connection closed.
```


## Via PuTTY

É possível abrir uma conexão túnel utilizando o utilitário **PuTTY** para Windows. No site https://www.ibm.com/support/pages/ssh-tunneling-putty existe uma breve explicação. Na opção _SSH_ / _Tunnels_ basta informar em _Source Port_ a porta do serviço (_5432_ para **Postgres** ou _3306_ para **MariaDB** por exemplo) e em _Destination_ o endereço IP do serviço (_172.1.**2**.201_ para **Postgres** ou _172.1.**9**.201_ para **MariaDB** respectivamente)


## Via código

Uma vez conectada à VPN do laboratório, é possível usar um túnel SSH para acessar os serviços do laboratório via código, como os de bancos de dados por exemplo:

```python
import csv
import redis
from sshtunnel import SSHTunnelForwarder

import decouple

config = decouple.AutoConfig(' ')
gpes_redis01_password = config('GPES_REDIS01_PASSWORD')
gpes_ssh_password = config('SSH_PASSWORD')

server = SSHTunnelForwarder(
    ('dev.labqs.ita.br', 2222),
    ssh_username = '<usuario da vpn>',
    ssh_password = gpes_ssh_password,
    remote_bind_address = ('172.1.7.201', 6379))

server.start()

r = redis.Redis(host = server.local_bind_host, port = server.local_bind_port, password = gpes_redis01_password)

server.stop()
```


## Via aplicativo

Uma vez conectada à VPN do laboratório, é possível usar um túnel SSH para acessar os serviços do laboratório dentro de uma aplicação (disponível em algumas), como os de bancos de dados:

![Configuração túnel SSH do "_Beekeeper_"](./images/beekeeper-ssh.png)

> *O arquivo informado em **Private key file** é o sem terminação (por exemplo: "**id_ed2551**" - sem "**.pub**" no final).*


# Senhas dos serviços WEB

Todos serviços web possuem um usuário, geralmente denominado **maint**, e uma senha de acesso que somente pode ser verificada via VPN do ITA.

A senha encontra-se no arquivo `.env` na pasta de cada serviço.

![Exemplo de sessão SSH para recuperar senhas do Postgres"](./images/sessaon-vpn-test.png)
