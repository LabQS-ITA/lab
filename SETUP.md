# Instalação do Laboratório de Testes de Software

## Requisitos

O Laboratório de Testes de Software roda sob **Linux** (testando com Alpine e Ubuntu) e necessita **Git**, **Docker**, **Docker Composer** para ser instalado e executado.

### Docker

Seguir as instruções em [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/).

> **OBSERVAÇÃO** - A instalação numa VM sob Xen não necessita a utilização de `sudo`.

Passos extraídos da página acima (usar a página como referência e não os passos listados abaixo), aqui listados apenas como conveniência eliminando o comando `sudo`:

#### Instalação para Ubuntu

##### Docker
```sh
apt-get update && apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

##### Docker composer

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
pip3 install docker-compose
```

#### Instalação para Debian

```sh
apt-get update && apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### Git

Instalar o **Git** a partir do repositório principal:

```bash
apt-get install -y git
```

## Pré-instalação

Basta clonar os fontes do repositório [GitHub](https://github.com/LabQS-ITA/lab.git).

```sh
git clone https://github.com/LabQS-ITA/lab.git LTS
```

## Configurações

No arquivo `common/config` existem configurações de cada serviço, como por exemplo:

```sh
export HTTPD_HOST=172.16.1.200

export POSTGRES_HOST=172.16.2.200
export POSTGRES_HOST01=172.16.2.201
export POSTGRES_HOST02=172.16.2.202
```

O funcionamento correto destas configurações de endereços IP é viabilizada pelo _script_ `common/create` que irá definir a rede e um volume comum para os certificados digitais. Deve ser executado uma única vez para definição inicial do ambiente de redes.

```sh
docker network create --driver bridge netlab01 --subnet='172.16.0.0/16'

docker volume create -d local certificates
```

## Instalação

Após clonar o repositório contendo o projeto LTS, executar os seguintes comandos na pasta onde foram copiados. O _script_ `setup` reconhece as seguintes opções de ambiente e configuração:

* Ambientes:
    * **tst** - testes do LabQS e prévia de deployments no ambiente de desenvolvimento
    * **dev** - ambiente de desenvolvimento e testes e prévia do ambiente de homologação
    * **hom** - ambiente de homologação
* Configuração:
    * **config** - informe esta opção caso deseje criar a configuração do ambiente

> **ATENÇÃO** - A opção **config** irá gerar os arquivos de configuração de ambiente. Estes arquivos contém chaves de acesso e senhas para os serviços correspondentes e são guardados no arquivo `.env` na pasta de cada serviço. A atualização destes arquivos num ambiente já definido pode inviabilizar acesso aos dados e ao serviço como um todo, pois mudança destas chaves e senhas não serão refletidas nas configurações dos serviços ou em seus bancos de dados

```sh
cd common
./setup tst
```

## Atualização

Existe um _script_ de atualização. Ele é necessário pois o _script_ de instalação (ver abaixo) irá modificar alguns arquivos inserindo senhas e nomes de domínios, e será necessário desfazer estas alterações para podermos atualizar os fontes.

```sh
cd common
./upd
```

> **OBSERVAÇÃO** - Após uma atualização podemos re-executar o _script_ `common/setup` para recriar os serviços afetados.

 ## Uso

 No documento [Guia de Uso](./USE.md) detalhamos a conexão e operação dos serviços.

> **OBSERVAÇÃO** - Cada serviço possui sua própria necessidade de configurações e administração. Os conhecimentos necessários para administrar, configurar e manter cada serviço não é objeto da documentação deste projeto.
