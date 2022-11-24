# Instalação do Laboratório de Testes de Software

## Requisitos

O Laboratório de Testes de Software roda sob **Linux** (testando com Alpine e Ubuntu) e necessita **Docker** e **Docker Composer** para ser instalado e executado.

## Pré-instalação

Basta clonar os fontes do repositório [GitHub](https://github.com/LabQS-ITA/lab.git).

```sh
git clone https://github.com/LabQS-ITA/lab.git .
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
docker-compose -f create.yaml up --detach
./setup tst
```


## Atualização

Existe um _script_ de atualização. Ele é necessário pois o _script_ de instalação (ver abaixo) irá modificar alguns arquivos inserindo senhas e nomes de domínios, e será necessário desfazer estas alterações para podermos atualizar os fontes.

```sh
./upd
```

 ## Uso

 No documento [Guia de Uso](./USE.md) detalhamos a conexão e operação dos serviços.

> **OBSERVAÇÃO** - Cada serviço possui sua própria necessidade de configurações e administração. Os conhecimentos necessários para administrar, configurar e manter cada serviço não é objeto da documentação deste projeto.
