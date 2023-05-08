# Requisitos para executar deploy/build em hosts remotos

É necessário ter Python3 instalado no _host_ remoto (geralmente está pré-instalado no **Ubuntu 20.40 LTS**).

Além disto é necessário instalar o utilitário _pip_ para poder instalar pacotes adicionais:

```sh
sudo apt install -y python3-pip

pip3 install docker docker-compose
```
