# Laboratório de Qualidade de Software

## Domínio de conhecimento

* _Ciência da Computação_
* _**Engenharia da Computação**_
* _Sistemas de Informação_

## Boas práticas

### Manifesto Ágil

* _**Indivíduos e interações** acima de processos e ferramentas_
* _**Software funcionando** acima de documentação completa_
* _**Colaboração do cliente** acima de negociação de contratos_
* _**Responder à mudanças** acima de seguir um plano_

## Propósito do laboratório

### Grupos de testes

* _**Acurácia** - a medida em que o resultado se aproxima do desejado, esperado ou correto_
* _**Precisão** - a variação do resultado na repetição do processo_
* _**Facilidade de uso** - atender as necessidades de quem usa_
* _**Privacidade e Segurança** - livre do uso ou divulgação indesejada, não autorizada ou imprevista da informação dos indivíduos e protegido de invasão ou sabotagem_
* _**Desempenho** - medição dos tempos de respostas em diferentes ambientes e cargas, disponibilidade e tolerância à falha_

### Tipos de testes

**Serão abordados**:

* **Funcionais**
    * _**Compatibilidade** - situação onde o uso pode ocorrer em diferentes ambientes tais como dispositivos, sistemas operacionais e navegadores_
    * _**Funcionalidade** - habilidade de executar suas funções com especificado e esperado_
    * _**Responsividade** - habilidade de responder rapidamente às tarefas demandadas e completá-las dentro de um tempo estimado como razoável dentro da expectativa do usuário_
    * _**Segurança** - extensão de proteção contra acesso não autorizado, invasão de privacidade, roubo, perda de dados, etc._
* **Não funcionais**
    * _**Concorrência** - habilidade de servir múltiplas requisições ao mesmo recurso ao mesmo tempo_
    * _**Desempenho** - velocidade na execução sob determinada carga_
    * _**Resiliência** - habilidade de executar as funcionalidades demandadas sob as condições pré-estabelecidas durante o tempo requerido sem nenhum erro_
    * _**Escalabilidade** - habilidade de aumentar ou diminuir o desempenho em resposta às mudanças nas demandas de processamento_
    * _**Estabilidade** - habilidade de permanecer estável sob diferentes cargas durante o uso_

**Não serão abordados**:

* **Funcionais**
    * _**Acessibilidade** - grau no qual pode ser usado com conforto por um amplo público, incluindo aqueles que necessitam tecnologias de assistência visual, auditiva e motora_
    * _**Localização** - habilidade ser utilizado em diferentes linguagens, fusos horários, etc._
    * _**Usabilidade** - grau de facilidade no uso_
* **Não funcionais**
    * _**Eficiência** - habilidade de executar bem e obter resultado sem desperdício de energia, recursos, esforço, tempo e dinheiro_
    * _**Facilidade de Instalar** - habilidade de ser instalado em determinado ambiente de dispositivos, sistemas operacionais e navegadores designados pela Compatibilidade_
    * _**Manutenibilidade** - facilidade de ser modificado - adição e extensão de funcionalidades, correção de erros, melhorias na eficiência_
    * _**Portabilidade** - habilidade de ser facilmente transferido de um ambiente para outro_
    * _**Testabilidade** - habilidade das funcionalidades serem facilmente verificadas e validadas_

## Implementação e uso do laboratório

A automação em estágios

### Ramos _**US000**_ do desenvolvedor

Ambiente de desenvolvimento e testes na máquina local dos desenvolvedores e inicio do primeiro estágio de integração.

![](./images/1010-lts-dev.png)

### Ramo _dev_

dev: será a origem do ambiente de testes e onde são executados testes unitários automatizados - atualizado durante a sprint ao final de cada US

![](./images/1020-lts-test.png)

### Ramo _master/main_

Origem do ambiente de homologação e onde são executados os testes dos usuários e demais clientes - atualizado após aprovação na revisão da corrida.

![](./images/1030-lts-hom.png)


## Passo-a-passo de processo de CI/CD

---

### Repositório de fontes LabQS

![](./images/0100-gitea.png)

---

### Criação de chaves de acesso no repositório privado na nuvem (GitHub, GitLab, BitBucket, etc.)

![](./images/0110-github-gitea-ssh-key.png)

---

### Criação de token de acesso no repositório de fontes do LabQS

![](./images/0120-gitea-ansible-access-token.png)

---

### Sincronizar repositorio de fontes do LabQS com repositório na nuvem

![](./images/0130-gitea-repository-mirroring.png)

---

### Gerenciamento de configurações

![](./images/0135-ansible.png)

---

### Registrar o token de acesso ao repositorio de fontes do LabQS no sistema de CM

![](./images/0140-ansible-gitea-access-token.png)

---

### Registrar o repositório e ramo do projeto no LabQS

![](./images/0150-ansible-repository.png)

---

### Registrar os servidores onde serão feitas as instalações

![](./images/0160-ansible-hosts.png)

---

### Modelo de tarefa de CI/CD

![](./images/0170-ansible-task-template.png)

---

### Tarefa de construção

![](./images/0180-ansible-task-build.png)

---

### Tarefa de instalação

![](./images/0190-ansible-task-deploy.png)

---

### Definição do processo de construção e instalação de um projeto

```yaml
- name: Deploy FluAlfa Docker container
  hosts: dev
  become: yes
  become_user: gpes
  remote_user: gpes
  tasks:
    
    - name: Clone FluAlfa repository
      copy:
        src: .
        dest: /home/gpes/flualfaapp

    - name: Build FluAlfa container
      community.docker.docker_compose:
        project_src: flualfaapp
        env_file: flualfaapp/.env.dev
        build: yes
```

---

### Descrição da imagem do container

```Dockerfile
FROM docker.io/node:16.17.0 as nodebase

FROM docker.io/php:7.4-cli as phpbase

COPY --from=nodebase /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodebase /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ENV FLUALFAAPP_PORT=10001
ENV FLUALFAAPP_HOST=172.1.100.1

RUN rm /etc/apt/preferences.d/no-debian-php

RUN apt-get update
RUN apt-get install -y wget php-cli php-zip php-pgsql unzip libpq-dev
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN pecl install xdebug

RUN echo "xdebug.mode=debug,coverage,profile,trace\n" > /usr/local/etc/php/conf.d/90-xdebug.ini
RUN echo "xdebug.remote_enable=1\n" >> /usr/local/etc/php/conf.d/90-xdebug.ini
RUN echo "xdebug.remote_connect_back=1\n" >> /usr/local/etc/php/conf.d/90-xdebug.ini
RUN echo "xdebug.discover_client_host=0\n" >> /usr/local/etc/php/conf.d/90-xdebug.ini
RUN echo "xdebug.client_host=$FLUALFAAPP_HOST\n" >> /usr/local/etc/php/conf.d/90-xdebug.ini

RUN docker-php-ext-install pdo pdo_pgsql
RUN docker-php-ext-enable xdebug

WORKDIR /dist/flualfa
COPY . /dist/flualfa

RUN composer self-update
RUN composer update
RUN npm install
RUN composer install

RUN cp .env.dev .env

RUN echo "#!/bin/bash\n" > /dist/start.sh
RUN echo "APP_ENV=dev php artisan key:generate\n" >> /dist/start.sh
RUN echo "APP_ENV=dev php artisan migrate\n" >> /dist/start.sh
RUN echo "npm run dev\n" >> /dist/start.sh
RUN echo "APP_ENV=dev php artisan route:clear\n" >> /dist/start.sh
RUN echo "APP_ENV=dev php artisan serve --host=$FLUALFAAPP_HOST --port=$FLUALFAAPP_PORT\n" >> /dist/start.sh
RUN chmod +x /dist/start.sh

CMD ["/dist/start.sh"]
```

---

### Descrição do container

```yaml
services:
  flualfaapp:
    container_name: flualfa
    image: mecita/flualfaapp:${FLUALFAAPP_TAG}
    restart: unless-stopped
    stdin_open: true
    tty: true
    build:
      context: .
      dockerfile: Dockerfile
      target: phpbase
    ports:
      - "${FLUALFAAPP_PORT}:80"
    networks:
      netlab01:
        ipv4_address: "${FLUALFAAPP_HOST}"
    volumes:
      - /usr/share/zoneinfo:/usr/share/zoneinfo:ro
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro

networks:
  netlab01:
    external: true
```

---

### Gerenciador de serviços

![](./images/0195-portainer.png)

---

### Imagem da aplicação criada no servidor

![](./images/0200-docker-image.png)

---

### Container da aplicação criado no servidor

![](./images/0210-docker-container.png)

---

### Aplicação rodando no servidor

![](./images/0220-application.png)

---

### Gerenciador de integração

![](./images/0225-drone.png)

---

### Definição do processo de integração e testes

```yaml
kind: pipeline
type: docker
name: default

steps:

  - name: install
    image: composer
    commands:
    - composer update
    - composer install
      
  - name: static
    image: php:7.4.30-cli
    failure: ignore
    commands:
    - vendor/bin/phpstan analyse app bootstrap config database resources/lang resources/views routes
    
  - name: unit
    image: php:7.4.30-cli
    commands:
    - php artisan test
    
  - name: coverage/mutation
    image: php:7.4.30-cli
    commands:
    - phpdbg -qrr vendor/bin/infection --threads=4
```

---

### Instalação da aplicação na integração

![](./images/0230-drone-install.png)

---

### Teste da aplicação na integração

![](./images/0240-drone-test.png)

---