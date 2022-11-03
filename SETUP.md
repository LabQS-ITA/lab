# Instalação do Laboratório de Testes de Software

## Requisitos

O Laboratório de Testes de Software roda sob **Linux** (testando com Alpine e Ubuntu) e necessita **Docker** e **Docker Composer** para ser instalado e executado.

## Pré-instalação

Basta clonar os fontes do repositório [GitHub](https://github.com/LabQS-ITA/lab.git).

```sh
git clone https://github.com/LabQS-ITA/lab.git .
```

## Instalação

Após clonar o repositório contendo o projeto LTS, executar os seguintes comandos na pasta onde foram copiados:

```sh
cd common
docker-compose -f create.yaml up --detach
./setup
```

> **ATENÇÃO**: após executar este comando, todas as senhas de todos os serviços serão regeradas e o acesso aos bancos de dados atuais será irremediavelmente perdido.

## Atualização

Existe um _script_ de atualização. Ele é necessário pois o _script_ de instalação (ver abaixo) irá modificar alguns arquivos inserindo senhas e nomes de domínios, e será necessário desfazer estas alterações para podermos atualizar os fontes.

```sh
./upd
```

 ## Uso

 No documento [Guia de Uso](./USE.md) detalhamos a conexão e operação dos serviços.
