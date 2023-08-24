# Configuração do Roteador de Serviços

## Antes

Utilizávamos o serviço **Apache/HTTPD** para executar a tarefa de _proxy_ para os serviços no *LabQS* expostos à internet.

Cada serviço é executado internamente num servidor dedicado, uma VM (_Virtual Machine_) ou num _Container_, e na configuração do Apache é adicionada uma especificação de caminho para o serviço interno, como por exemplo:

### Caminho simples para serviço interno

```xml
<VirtualHost *:443>
  
    ServerName labqs.ita.br

    ProxyPass /netdata http://netdata:19999/
    ProxyPassReverse /netdata http://netdata:19999/

</VirtualHost>
```

No exemplo, o caminho internet `https://labqs.ita.br/netdata` será redirecionado para uma VM ou um _Container_ chamado _netdata_ que está respondendo via HTTP pela porta _19999_ na rede interna e é inacessível de outro modo.

### Caminho para um serviço com sub-domínio

Em alguns caso a aplicação não possui configuração para responder à caminhos (como `/netdata`) e podem responder apenas para `/` (a raiz do serviço).

```xml
<VirtualHost _default_:443>

    ServerName ci.labqs.ita.br

    ProxyPass / http://drone:80/
    ProxyPassReverse / http://drone:80/


</VirtualHost>
```

No exemplo, o caminho internet `https://ci.labqs.ita.br` será redirecionado para uma VM ou _Container_ chamdado _drone_ que responde via HTTP pela porta _80_ na rede interna e é inacessível de outro modo.

### Configuração de balanceamento de carga

Pode ser necessário ainda termos um único caminho apontando para várias VMs ou _Containers_ internos para fins de balanceamento de carga para os casos que exigem uma grande demanda ou um único servidor não é capaz de atender a demanda exigida ou ainda é desejável termos espelhamento e distribuição de dados para fins de alta disponibilidade e resiliência do serviço.

```xml
<VirtualHost _default_:443>

    ServerName storage.labqs.ita.br

    <Proxy balancer://storagews>
        BalancerMember ws://storage01:9000 flushpackets=on
        BalancerMember ws://storage02:9000 flushpackets=on
        BalancerMember ws://storage03:9000 flushpackets=on
        BalancerMember ws://storage04:9000 flushpackets=on
        BalancerMember ws://storage05:9000 flushpackets=on
        BalancerMember ws://storage06:9000 flushpackets=on
        BalancerMember ws://storage07:9000 flushpackets=on
        BalancerMember ws://storage08:9000 flushpackets=on
        ProxySet lbmethod=byrequests
    </Proxy>

    ProxyPass / balancer://storagews/
    ProxyPassReverse / balancer://storagews/

</VirtualHost>
```

No exemplo, o caminho internet `https://storage.labqs.ita.br` será redirecionado para várias VMs ou _Containers_ chamados _storageNN_ que respondem via WebSocket pela porta _9000_ na rede interna e são inacessíveis de outro modo.

> **Obs**.: _O serviço **Apache/HTTPD** possui ainda configurações específicas para `WebSocket`._

## Problema desta solução e solução proposta

Apesar de bastante simples, temos duas configurações separadas para disponibilizar um mesmo serviço.

Como solução implementamos um serviço de roteamento e balanceamento de carga em substituição ao **Apache/HTTPD** - adotamos o serviço **Traefik** para esta finalidade.

A vantagem do **Traefik** com relação ao **Apache/HTTPD** é que toda a configuração do roteamento e balanceamento de carga é feita junto à definição da VM ou do _Container_. As definições são mais simples também (balanceamento de carga é padrão para todas definições no **Traefik**).

Todos os serviços do **LabQS** são atualmente _Containers_ **Docker**, então vamos listar as modalidades de configurações adotadas no arquivo `stack.yaml` que adotamos para definir cada um.

### Caminho simples para serviço interno

```yaml
    labels:
      - traefik.enable=true
      - traefik.http.routers.netdata.rule=Host(`labqs.ita.br`) && PathPrefix(`/netdata`)
      - traefik.http.routers.netdata.tls=true
      - traefik.http.services.netdata.loadbalancer.server.port=19999
      - traefik.http.middlewares.netdata-stripprefix.stripprefix.prefixes=/netdata
      - traefik.http.middlewares.netdata-stripprefix.stripprefix.forceSlash=true
      - traefik.http.routers.netdata.middlewares=netdata-stripprefix@docker
```

No exemplo acima, o serviço `netdata` respondendo pela porta `19999` será encontrado em `https://labqs.ita.br/netdata`.

> **Obs**.: _No exemplo, estamos removendo o caminho `/netdata` repassado para o _Container_, mas em alguns casos isso pode não ser necessário_

### Caminho para um serviço com sub-domínio

```yaml
      - traefik.enable=true
      - traefik.http.routers.drone.rule=Host(`ci.labqs.ita.br`)
      - traefik.http.routers.drone.tls=true
      - traefik.http.services.drone.loadbalancer.server.port=80
```

No exemplo acima, o serviço `drone` respondendo pela porta `80` será encontrado em `https://ci.labqs.ita.br`.

### Configuração de balanceamento de carga

```yaml
      - traefik.enable=true
      - traefik.http.routers.storage01.rule=Host(`storage.labqs.ita.br`)
      - traefik.http.routers.storage01.tls=true
      - traefik.http.services.storage01.loadbalancer.server.port=9000
```

Este é um caso onde a configuração no apache é menos verbosa, mas ainda assim teremos toda configuração do serviço junto à definição dos _Containers_. Para cada container de nosso _Cluster_ deveremos repetir a configuração acima (`storage02`, `storage03`, etc.) mantendo o mesmo _Host_ `storage.labqs.ita.br` e a mesma porta `9000`.