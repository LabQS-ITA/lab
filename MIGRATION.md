# Migração de ambientes do LabQS

Este procedimento descreve a migração de um dos ambientes do LabQS para uma máquina virtual criada em outro servidor.

## Dealocar espaço para máquinas virtuais

Caso todo espaço dos discos físicos tenha sido alocado para o Volume Group do sistema operacional, basta identificar e dealocar o espaço desejado para a criação de volumes lógicos para as máquinas virtuais.

```sh
sudo pvdisplay -v

  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               ubuntu-vg
  PV Size               277.36 GiB / not usable 3.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              71004
  Free PE               5248
  Allocated PE          65756
  PV UUID               dQ06yT-P4tN-8MfF-i5d3-l4Xb-I5ei-w3Ayk3

  --- Physical volume ---
  PV Name               /dev/sdb
  VG Name               ubuntu-vg
  PV Size               558.88 GiB / not usable 1.96 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              143073
  Free PE                   0
  Allocated PE          143073
  PV UUID               jlgyPw-iVTs-yZDi-ZhJ5-k1hG-0e8H-ty4ONO

sudo lvresize -l -143073 /dev/mapper/ubuntu--vg-ubuntu--lv
```

## Preparar máquina virtual

Vamos criar uma máquina virtual para abrigar o ambiente completo do laboratório

### Criar configuração

A máquina virtual para o ambiente de homologação terá:
1. 8Gb de memória
2. 200Gb de espaço em disco
3. Endereço IP interno do host

```sh
sudo xen-create-image \
    --hostname='labqs.ita.br' \
    --memory=8gb \
    --vcpus=2 \
    --lvm=ubuntu-vg  \
    --size=200Gb \
    --ip=172.31.100.1 \
    --netmask=172.31.0.0 \
    --broadcast=172.31.255.255 \
    --netmask=255.255.0.0 \
    --gateway=172.31.0.1 \
    --nameserver=161.24.23.180 \
    --randommac \
    --bridge=xenbr0 \
    --role=labqs \
    --pygrub \
    --dist=focal \
    --password='c0r0n@' \
    --verbose
```

### Criar máquina virtual

Uma vez definida a configuração basta criar a máquina virtual:

```sh
sudo xl create /etc/xen/labqs.ita.br.cfg
```

### Acionar máquina virtual

Agora iremos instalar as ferramentas necessárias para executar o ambiente do laboratório na máquina virtual:

```sh
ssh -p 2222 root@172.31.100.1
```

### Instalar ferramentas para criação do ambiente

Estamos utilizando o Docker. Para instalá-lo basta seguir instruções em https://docs.docker.com/engine/install/ubuntu/ para instalação do Docker.

### Clonar repositório contendo o LabQS

Toda a configuração está num repositório Git, bastando cloná-lo:

```sh
git clone https://github.com/LabQS-ITA/lab.git
```

## Configurar o laboratório

É necessária criar a rede virtual para o laboratório, e em seguida executar o script que irá criar todos os containers dos serviços para o ambiente. Estamos utilizando o ambiente de homologação que é mais simples por não ter os serviços de desenvolvimento instalados:

```sh
cd lab/common
./create
./setup hom config
```

### Mapear portas de rede dos serviços

Uma vez criados os serviços é necessário mapear as portas do servidor host para a máquina virtual para que os serviços sejam acessados externamente. Os comandos abaixo devem ser executados no servidor host:

```sh
sudo iptables -t nat -A PREROUTING -i enp2s0f0 -p tcp -m tcp --dport 80 -j DNAT --to-destination 172.31.100.1:80
sudo iptables -t nat -A PREROUTING -i enp2s0f0 -p tcp -m tcp --dport 443 -j DNAT --to-destination 172.31.100.1:443
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

### Migrar certificados

Para acessar as páginas dos serviços usando HTTPS, é necessário instalar os certificados digitais na máquina virtual. Executando no servidor host vamos copiar um backup dos certificados digitais e em seguida vamos copia-lo para a máquina virtual.

```sh
sftp -P 2222 gpes@labqs.ita.br
get bkp_certificates_2023-01-10-1351.volume.tar.gz
exit
sftp -P 2222 root@172.31.100.1
put bkp_certificates_2023-01-10-1351.volume.tar.gz
exit
```

Agora vamos instalar os certificados digitais na máquina virtual, disponibilizando-os para o container Docker do servidor Apache:

```sh
ssh -p 2222 root@172.31.100.1
gunzip bkp_certificates_2023-01-10-1351.volume.tar.gz
tar xvf bkp_certificates_2023-01-10-1351.volume.tar
cd source-volume
cp -R * /var/lib/docker/volumes/certificates/_data
```

### Reiniciar servidor apache

Para o servidor apache usar os certificados ele deve ser re-iniciado (possivelmente ele estará executando com erros pois os arquivos dos certificados são referenciados na configuração mas não estavam disponíveis):

```sh
docker restart httpd
```

### Apontar o DNS para o novo servidor

Agora devemos apontar o nome do ambiente escolhido (em nosso caso labqs.ita.br - o ambiente de homologação) para o endereço IP do servidor host que será o novo servidor do ambiente migrado. Uma vez o servidor DNS atualizado e a configuração propagada pela internet, podemos testar o novo ambiente.
