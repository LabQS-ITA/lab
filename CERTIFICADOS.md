# Atualização dos certificados digitais dos ambientes do LabQS

O _script_ [certificates](./common/certificates) atualiza os certificados digitais utilizando um _container_ **Docker** (configurado em [stack.yaml](./certbot/stack.yaml)):

```sh
#!/usr/bin/env bash
set -euo pipefail


if [[ $# -ne 1 ]]; then

    echo "Informe [ dev | tst | hom ]"

    exit 1

elif [ "$1" == "tst" ]; then

    # Servidor do lab
    export LAB_DOMAIN=test.labqs.ita.br
    export CI_LAB_DOMAIN=ci.test.labqs.ita.br
    export CM_LAB_DOMAIN=cm.test.labqs.ita.br

elif [ "$1" == "dev" ]; then

    # Servidores de desenvolvimento e testes
    export LAB_DOMAIN=dev.labqs.ita.br
    export CI_LAB_DOMAIN=ci.labqs.ita.br
    export CM_LAB_DOMAIN=cm.labqs.ita.br

elif [ "$1" == "hom" ]; then

    # Servidores de homologação
    export LAB_DOMAIN=labqs.ita.br
    export CI_LAB_DOMAIN=ci.labqs.ita.br
    export CM_LAB_DOMAIN=cm.labqs.ita.br
    
else

    echo "Argumento $1 incorreto. Use [ dev | tst | hom ]"

    exit 1

fi

source ./config

cd ../certbot
echo '* Letsencrypt certbot *'

echo 'Certificar que apache está parado'
docker stop httpd

if [ "$1" == "hom" ]; then
    export CERT_DOMAINS=$LAB_DOMAIN
else
    export CERT_DOMAINS=$LAB_DOMAIN,$CI_LAB_DOMAIN,$CM_LAB_DOMAIN
fi
echo 'Registrando '${CERT_DOMAINS}

# Usando docker
# Verificar em stack.yml se está configurado para criação ou renovação
docker compose -f stack.yaml -f ../common/volumes.$1.yaml up --detach
echo "$(tput setaf 1)Aguarde a finalização da execução$(tput sgr0)"
docker logs certbot --follow

# Usando letsencrypt
# sudo certbot certonly --standalone --agree-tos -m gomesjm@ita.br -n -d ${CERT_DOMAINS}
# sudo certbot renew --force-renewal

echo "$(tput setaf 1)Re-inicar apache com script setup$(tput sgr0)"
```

Na configuração do _container_, a criação dos certificados está **desabilitada**. Para habilitar basta comendar a linha contendo `- '--dry-run'`:

```yaml
services:

  certbot:
    container_name: certbot
    image: certbot/certbot
    ports:
      - '80:80'
      - '443:443'
    networks:
      netlab01:
        ipv4_address: ${CERTBOT_HOST}
    volumes:
      - certificates:/etc/letsencrypt:rw
      - $PWD/var/log:/var/log:rw
      - /usr/share/zoneinfo:/usr/share/zoneinfo:ro
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    command: 
      - 'renew'
      - '--force-renewal'
      # - 'certonly'
      # - '--standalone'
      # - '--agree-tos'
      # - '-m gomesjm@ita.br'
      # - '-n'
      # - '-d ${CERT_DOMAINS}'
      # - '--dry-run'

volumes:
  certificates:
    name: certificates
    external: true

networks:
  netlab01:
    external: true
```

Após a recriação do certificado re-iniciar o serviço **HTTPD* com o _script_ `setup`.
