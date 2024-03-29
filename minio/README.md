## Configurar repositórios

### Registrar super usuário 

```sh
mc alias set st-test-maint https://st.test.labqs.ita.br maint ::senha::
mc alias set st-hom-maint https://st.labqs.ita.br maint ::senha::
```

> **Obs**.: _para gerar senhas usamos o comando `openssl rand -hex 8`_

### Trace

```sh
mc admin trace st-test-maint
mc admin trace st-hom-maint
```

### Logs

```sh
mc admin logs st-test-maint
mc admin logs st-hom-maint
```

### Criar bucket

#### FAB

```sh
mc mb st-hom-maint/fabdata --with-versioning
```

#### FluAlfa

```sh
mc mb st-test-maint/flualfa --with-versioning
mc mb st-hom-maint/flualfa --with-versioning
```

### Criar usuários

#### FAB

```sh
mc admin user add st-hom-maint fab-ro `openssl rand -hex 8`
mc admin user add st-hom-maint fab-rw `openssl rand -hex 8`
```

#### FluAlfa

```sh
mc admin user add st-test-maint flualfa-ro `openssl rand -hex 8`
mc admin user add st-test-maint flualfa-rw `openssl rand -hex 8`

mc admin user add st-hom-maint flualfa-ro `openssl rand -hex 8`
mc admin user add st-hom-maint flualfa-rw `openssl rand -hex 8`
```

#### Nextcloud

```sh
mc admin user add st-test-maint nextcloud-ro `openssl rand -hex 8`
mc admin user add st-test-maint nextcloud-rw `openssl rand -hex 8`

mc admin user add st-hom-maint nextcloud-ro `openssl rand -hex 8`
mc admin user add st-hom-maint nextcloud-rw `openssl rand -hex 8`
```

#### LabelStudio

```sh
mc admin user add st-test-maint labelstudio-ro `openssl rand -hex 8`
mc admin user add st-test-maint labelstudio-rw `openssl rand -hex 8`

mc admin user add st-hom-maint labelstudio-ro `openssl rand -hex 8`
mc admin user add st-hom-maint labelstudio-rw `openssl rand -hex 8`
```


### Criar grupo

#### FAB

```sh
mc admin group add st-hom-maint fab-ro fab-ro
mc admin group add st-hom-maint fab-rw fab-rw
```

#### FluAlfa

```sh
mc admin group add st-test-maint flualfa-ro flualfa-ro
mc admin group add st-test-maint flualfa-rw flualfa-rw

mc admin group add st-hom-maint flualfa-ro flualfa-ro
mc admin group add st-hom-maint flualfa-rw flualfa-rw
```

#### Nextcloud

```sh
mc admin group add st-test-maint nextcloud-ro nextcloud-ro
mc admin group add st-test-maint nextcloud-rw nextcloud-rw

mc admin group add st-hom-maint nextcloud-ro nextcloud-ro
mc admin group add st-hom-maint nextcloud-rw nextcloud-rw
```

#### LabelStudio

```sh
mc admin group add st-test-maint labelstudio-ro labelstudio-ro
mc admin group add st-test-maint labelstudio-rw labelstudio-rw

mc admin group add st-hom-maint labelstudio-ro labelstudio-ro
mc admin group add st-hom-maint labelstudio-rw labelstudio-rw
```


### Criar política

#### FAB

Arquivo `fab-ro.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": [
                "arn:aws:s3:::fabdata/*"
        ]
    }]
}
```

Arquivo `fab-rw.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
                "arn:aws:s3:::fabdata/*"
        ]
    }]
}
```

#### FluAlfa

Arquivo `flualfa-ro.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": [
                "arn:aws:s3:::flualfa/*",
                "arn:aws:s3:::flualfa-dev/*"
        ]
    }]
}
```

Arquivo `flualfa-rw.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
                "arn:aws:s3:::flualfa/*",
                "arn:aws:s3:::flualfa-dev/*"
        ]
    }]
}
```

#### LabelStudio

Arquivo `labelstudio-ro.policy.json`

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:GetBucketLocation",
            "s3:GetBucketVersioning",
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::labelstudio/*"
        ]
    }]
}
```

Arquivo `labelstudio-rw.policy.json`

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
            "arn:aws:s3:::labelstudio/*"
        ]
    }]
}
```


### Associar _política_ ao _grupo_:

#### FluAlfa

```sh
mc admin policy create st-hom-maint fab-ro ./fab-ro.policy.json && \
mc admin policy attach st-hom-maint fab-ro --group fab-ro && \
mc admin policy create st-hom-maint fab-rw ./fab-rw.policy.json && \
mc admin policy attach st-hom-maint fab-rw --group fab-rw
```

#### FluAlfa

```sh
mc admin policy create st-test-maint flualfa-ro ./flualfa-ro.policy.json && \
mc admin policy attach st-test-maint flualfa-ro --group flualfa-ro && \
mc admin policy create st-test-maint flualfa-rw ./flualfa-rw.policy.json && \
mc admin policy attach st-test-maint flualfa-rw --group flualfa-rw && \
mc admin policy create st-hom-maint flualfa-ro ./flualfa-ro.policy.json && \
mc admin policy attach st-hom-maint flualfa-ro --group flualfa-ro && \
mc admin policy create st-hom-maint flualfa-rw ./flualfa-rw.policy.json && \
mc admin policy attach st-hom-maint flualfa-rw --group flualfa-rw
```

#### LabelStudio

```sh
mc admin policy create st-test-maint labelstudio-ro ./labelstudio-ro.policy.json && \
mc admin policy attach st-test-maint labelstudio-ro --group labelstudio-ro && \
mc admin policy create st-test-maint labelstudio-rw ./labelstudio-rw.policy.json && \
mc admin policy attach st-test-maint labelstudio-rw --group labelstudio-rw && \
mc admin policy create st-hom-maint labelstudio-ro ./labelstudio-ro.policy.json && \
mc admin policy attach st-hom-maint labelstudio-ro --group labelstudio-ro && \
mc admin policy create st-hom-maint labelstudio-rw ./labelstudio-rw.policy.json && \
mc admin policy attach st-hom-maint labelstudio-rw --group labelstudio-rw
```

#### Configuração em Nextcloud:

Repositório de áudios (somente leitura):

![](../images/st/flualfa-nextcloud-st.png)

Acesso à pasta:

![](../images/st/flualfa-nextcloud-st-share.png)


#### Configuração em LabelStudio

Repositório de áudios (somente leitura):

![](../images/st/flualfa-labelstudio-st.png)

Repositório para as rotulações (leitura/gravação):

![](../images/st/labelstudio-st.png)

Acesso à pasta:

![](../images/st/flualfa-labelstudio-share.png)

