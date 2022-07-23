# Inclusão de projetos no processo de Integração Contínua

## Replicação de um projeto no repositório do Laboratório


Copiar a URL do projeto no repositório externo:

![](../images/drone-ci-01.png)

---

No repositório da organização no Controle de Fontes do laboratório escolher a opção "New Migration":

![](../images/drone-ci-02.png)

---

Iniciar a migração para o tipo correspondente de repositório externo (GitHub, GitLab, Bitbucket, etc.) e informar a URL anotada no passo anterior:

![](../images/drone-ci-03.png)

---

Informar o "Personal Access Token" criado no repositório externo (instruções de como fazê-lo deve ser obtida na documentação do serviço externo):

![](../images/drone-ci-04.png)

---

Recomendamos tornar o repositório "Privado" e iniciar a migração com a opção "Migrate Repository":

![](../images/drone-ci-05.png)

---

Uma vez migrado o repositório será replicado periodicamente no serviço de fontes do Laboratório:

![](../images/drone-ci-06.png)

---

Recomendamos também ajustar o período de sincronização para 1h:

![](../images/drone-ci-07.png)

---

Uma vez migrado o repositório para o serviço de fontes, devemos sincronizar o serviço de integração contínua com a opção "Sync":

![](../images/drone-ci-08.png)

---

Uma vez sincronizado, o novo repositório poderá ser ativado:

![](../images/drone-ci-09.png)

---

Podemos então adicionar um novo "build":

![](../images/drone-ci-10.png)

---

Devemos especificar um dos ramos de fontes (no exemplo o ramo "dev"):

![](../images/drone-ci-11.png)

---

Uma vez inserido, o novo "build" irá ser processado

![](../images/drone-ci-12.png)

---

Poderemos observar o progresso do "build":

![](../images/drone-ci-13.png)

---

O erro apresentado foi causado pela falta de uma imagem "Docker" na especificação da [`Pipeline`](PIPELINE.md) "pipeline" de processamento do "build":

![](../images/drone-ci-14.png)

---