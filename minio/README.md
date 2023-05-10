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

#### FluAlfa

```sh
mc mb st-test-maint/flualfa --with-versioning
mc mb st-hom-maint/flualfa --with-versioning
```

#### Nextcloud

```sh
mc mb st-test-maint/nextcloud --with-versioning
mc mb st-hom-maint/nextcloud --with-versioning
```

### Criar usuários

#### FluAlfa

```sh
mc admin user add st-test-maint flualfa-ro ::senha::
mc admin user add st-test-maint flualfa-rw ::senha::

mc admin user add st-hom-maint flualfa-ro ::senha::
mc admin user add st-hom-maint flualfa-rw ::senha::
```

#### Nextcloud

```sh
mc admin user add st-test-maint nextcloud-ro f1f503c2ddbf1776
mc admin user add st-test-maint nextcloud-rw cd060e3bba6b5bce

mc admin user add st-hom-maint nextcloud-ro 7cb016fd36a50bb9
mc admin user add st-hom-maint nextcloud-rw 0e5917820d0c5f59
```


### Criar grupo

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

### Criar política

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
            "arn:aws:s3:::flualfa/*"
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
            "arn:aws:s3:::flualfa/*"
        ]
    }]
}
```


#### Nextcloud

Arquivo `nextcloud-ro.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:GetBucketLocation",
            "se:GetBucketVersioning",
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::nextcloud/*"
        ]
    }]
}
```

Arquivo `nextcloud-rw.policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
            "arn:aws:s3:::nextcloud/*"
        ]
    }]
}
```

### Associar _política_ ao _grupo_:

#### FluAlfa

```sh
mc admin policy create st-test-maint flualfa-ro ./flualfa-ro.policy.json
mc admin policy attach st-test-maint flualfa-ro --group flualfa-ro

mc admin policy create st-test-maint flualfa-rw ./flualfa-rw.policy.json
mc admin policy attach st-test-maint flualfa-rw --group flualfa-rw

mc admin policy create st-hom-maint flualfa-ro ./flualfa-ro.policy.json
mc admin policy attach st-hom-maint flualfa-ro --group flualfa-ro

mc admin policy create st-hom-maint flualfa-rw ./flualfa-rw.policy.json
mc admin policy attach st-hom-maint flualfa-rw --group flualfa-rw
```

#### Nextcloud

```sh
mc admin policy create st-test-maint nextcloud-ro ./nextcloud-ro.policy.json
mc admin policy attach st-test-maint nextcloud-ro --group flualfa-ro

mc admin policy create st-test-maint nextcloud-rw ./nextcloud-rw.policy.json
mc admin policy attach st-test-maint nextcloud-rw --group nextcloud-rw

mc admin policy create st-hom-maint nextcloud-ro ./nextcloud-ro.policy.json
mc admin policy attach st-hom-maint nextcloud-ro --group nextcloud-ro

mc admin policy create st-hom-maint nextcloud-rw ./nextcloud-rw.policy.json
mc admin policy attach st-hom-maint nextcloud-rw --group nextcloud-rw
```

### Chaves de acesso

#### FluAlfa

```sh
mc admin user svcacct add --access-key "1F4IC0mliCgfS5hl" --secret-key "uV2b4Ixqo3xo9aBptzIDlLviO2CTFtLI" st-test-maint flualfa-rw
```

#### Nextcloud

Armazenamento do serviço:

```sh
mc admin user svcacct add --access-key "YY79MESQLPD8SAC2KN5L" --secret-key "96bo7gRjpTdyy5IR34CrE1uFMQPUfGEqBk8nXAUr" st-test-maint nextcloud-rw
```

Acesso à FluAlfa:

```sh
mc admin user svcacct add --access-key "ZC435HMZLB5PC3D9YCRH" --secret-key "m0qaRR4KD1Z+7pLwiWCv2x3l7xfqLpK3qpvb6j+K" st-test-maint flualfa-ro
```

Configuração em Nextcloud:

![](../../images/flualfa-nextcloud-st.png)
