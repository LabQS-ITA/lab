# Acessar aplicação instalada localmente num servidor remoto

## Determinar IP público

Determinar o endereço IP da sua conexão na internet usando seu roteador ou consultando algum serviço de internet que responde com seu endereço externo:

![Endereço IP público](./images/01-ip-address.png)

## Habilitar conexões externas

Muitos roteadores domésticos vem com proteção para conexões externas:

![Conexões externas](./images/02-enable-connections.png)

## Mapear porta da aplicação para permitir conexão externa

Independente da proteção do roteador, os provedores disabilitam a publicação de portas abaixo de 8000 nas redes domésticas, então temos que mapear a porta da aplicação, ou publicar a aplicação numa porta acima da 8000:

### Opção de mapear a porta

Caso a aplicação use a porta `3000`:

```javascript
    const PORT = 3000
    app.listen(PORT, () => {
        console.log(`🔥  Servidor iniciado na porta: ${PORT}`)
    })
```

![Mapear porta da aplicação](./images/03-route-port.png)

### Opção de publicar uma porta acima de 8000

Caso deseje alterar a aplicação para usar a porta `9000`:

```javascript
    const PORT = 9000
    app.listen(PORT, () => {
        console.log(`🔥  Servidor iniciado na porta: ${PORT}`)
    })
```

## Configurar serviço apache para acessar a aplicação local

O serviço *http* deve ser configurado corretamente para acessar a aplicação local. Antes disso o _container_ deve estar habilitado a acessar o _host_. No arquivo `stack.yaml` do serviço *htttp* deve ser adicionada a cláusula:

```yaml
    extra_hosts:
      - host.docker.internal:172.16.0.1
```

> *Obs.:* o endereço `172.16.0.1` corresponde ao _gateway_ da rede *netlab01* criada no script *create*:
> ```sh
> docker network create --driver bridge netlab01 --subnet='172.16.0.0/16'
> ```

Na configuração do serviço *http* é acrescentado o caminho para a aplicação:

```yaml
    ProxyPass /localhost http://host.docker.internal:10004
    ProxyPassReverse /localhost http://host.docker.internal:10004
```

## Configurar _host_ para redirecionar para a máquina externa partindo da porta local para a porta remota

No servidor criar as rotas para a máquina do *desenvolvedor*. Aqui estamos usando a porta `9000` escolhida acima que será mapeada para a porta `10004` no servidor:

```sh
sudo iptables -t nat -A PREROUTING -p tcp --dport 10004 -j DNAT --to-destination 179.118.164.135:9000
sudo iptables -t nat -A OUTPUT -p tcp --dport 10004 -j DNAT --to-destination 179.118.164.135:9000
```

### Excluir o roteamento

Caso deseje alterar ou simplesmente excluir o roteamento:

#### Listar as rotas

```sh
sudo iptables -L -t nat --line-numbers
```

Identificar o número da linha das rotas em *PREROUTING* e *OUTPUT* e excluí-las:

```sh
sudo iptables -t nat -D PREROUTING 2
sudo iptables -t nat -D OUTPUT 2
```

## Testar acesso externo à aplicação local

Usando o _browser_ acessar sua aplicação local:

`http://179.118.164.135:9000`

## Testar acesso via servidor

Usando o _browser_ acessar sua aplicação remotamente:

`https://test.labqs.ita.br/localhost`
