## Requisitos para executar deploy/build em hosts remotos

É necessário ter Python3 instalado no _host_ remoto (geralmente está pré-instalado no **Ubuntu 20.40 LTS**).

Além disto é necessário instalar o utilitário _pip_ para poder instalar pacotes adicionais:

```sh
sudo apt install -y python3-pip

pip3 install docker docker-compose
```

## Adicionar usuários

No container de *semaphore* executar o comando:

```sh
semaphore user add --name 'Breslei' --login 'breslei' --email 'bresleimax@rocketmail.com' --password '<senha>'  --config /etc/semaphore/config.json
semaphore user add --name 'Matheus' --login 'matheus' --email 'matheussilvamartins1714@gmail.com' --password '<senha>'  --config /etc/semaphore/config.json
```
