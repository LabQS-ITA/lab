## Acesso aos de arquivos de coleta do FluAlfa

### Acessar Gerenciador de Armazenamento

Antes criar o usuário para acessos de leitura/gravação e somente leitura:

```sh
mc admin user svcacct add st-test-maint labelstudio-rw

mc admin user svcacct add st-hom-maint labelstudio-rw

mc admin user svcacct add st-test-maint labelstudio-ro

mc admin user svcacct add st-hom-maint labelstudio-ro
```

> **Obs**.: _Anotar os valores retornados_

Em seguida configurar o rotulador de dados:

Repositório de áudios (somente leitura):

![](../images/st/flualfa-labelstudio-st.png)

Repositório para as rotulações (leitura/gravação):

![](../images/st/labelstudio-st.png)

Acesso à pasta:

![](../images/st/flualfa-labelstudio-share.png)
