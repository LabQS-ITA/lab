# Serviço de administração dos ambientes do Laboratório de Testes de Software

O Laboratório de Testes de Software compõe três ambientes:

![Ambientes do Laboratório de Testes de Software](../images/lts.png)

1. **Desenvolvimento** - _onde os desenvolvedores terão suporte para testes unitários e de integração automatizados, servidores de bancos de dados, de aplicação e portais para estas aplicações - este ambiente irá prover os desenvolvedores de feedback sobre integridade e qualidade de código, padrões de codificação e de implementação por eles próprios definidos e aferição básica de qualidade_
1. **Testes** - _onde de testes que será atualizados por meio de *scripts* e com versões originadas do repositório de fontes (apenas versões "liberadas" pelos desenvolvedo serão "promovidas" para o ambiente de testes) - neste ambiente serão verificados se as entregas atendem ou não os critérios de aceitação estabelecidos durante as fases de concepção além de critérios de aceitação globais estabelecidos pelos product-owners_
1. **Homologação** - _Artefatos aprovados no ambiente de testes serão replicados no ambiente de homologação, onde serão expostos aos clientes (stakeholders e também product-owners) para validação dos critérios de aceitação e revisão contínua do progresso do projeto_

## Acesso aos ambientes

Cada ambiente conta com um servidor `HTTPD` que serve de _front-end_ para os serviços disponibilizados para cada.

Teremos também um serviço único de controle de versões e integração/entrega continuas (CI/CD - _continous integration & continous delivery_) que fará o fluxo de trabalho que integra os ambientes de desenvolvimento e testes.

Contamos ainda com um serviço centralizado de artefatos para o projeto que será a ponte entre os ambientes de testes e homologação.

O acesso a cada ambiente se fará por meio de uma porta a partir do endereço centralizado do projeto.

## Configuração do _front-end_ dos ambientes

A configuração dos serviços se faz por meio do arquivo [stack.yaml](./stack.yaml) e nele temos a configuração individual de cada um.

Na pasta `httpd` temos os arquivos de configuração do servidor **Apache** e seguem o padrão deste (ver [Apache HTTP Server Version 2.4 Documentation](https://httpd.apache.org/docs/2.4/)).

O arquivo [httpd.conf](sc/config/httpd.conf) foi customizado com a adição da clásula

```
IncludeOptional conf/sites/*.conf
```

Isso permiti a inclusão de novos serviços, como é feita comumente nos servidores **HTTPD**. Em [httpd01/config/sites](sc/config/sites) por exemplo temos um arquivo [default.conf](sc/config/sites/default.conf) com a configuração do _front-end_ para o ambiente de desenvolvimento:

```xml
<VirtualHost *:80>

    ErrorLog logs/error.log
    CustomLog logs/access.log combined

    ProxyPass /gitlab http://gitlab:80
    ProxyPassReverse /gitlab http://gitlab:80
	
</VirtualHost>
````

> **OBSERVAÇÃO**: O serviço de controle de versões e integração/entrega contínuos pode atender todos os ambientes e foge portanto à regra de ter um sufixo numerado.

A página inicial (e geralmente única) de cada _front-end_ deve ser atualizada para apontar para o serviço do ambiente. Para isto em [httpds01/static](sc/static) temos um arquivo [index.html](sc/static/index.html) onde podemos acrescentar na lista de ítens navegáveis o serviço desejado:

```html
    <body>
        <article>
            <h1>Projeto Análise de Fluência!</h1>
            <h2>Serviços de Desenvolvimento</h2>
            <div>
                <div style="display: table-cell; max-width: 250px; vertical-align: top;" id="pano">
                    <img src="./hourglass.gif" style=" max-width: 90%; margin: 5%; " />
                </div>
                <ul>
                    <li><a href="/gitlab">Controle de fontes/Integração Contínua</a></li>
                </ul>
            </div>
        </article>
    </body>
```