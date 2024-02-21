# Usando **conda** no projeto Jupyter

_Author: CAP AV Carlos Renato de Andrade Figueiredo_


Complementando as informações em [Ambientes virtuais no Jupyter](./VIRTUALENV.md) - criar um arquivo `.condarc` na pasta do `<projeto>`:

```yaml
envs_dirs:
    - /home/jovyan/work/<projeto>/.conda/envs

pkgs_dirs:
    - /home/jovyan/work/<projeto>/.conda/pkgs
```

Copia essa arquivo para pasta do usuário (`/home/jovyan`):

```sh
cp /home/jovyan/work/<projeto>/.condarc /home/jovyan/
```

Verificar se os diretórios foram setados corretamente:

```sh
conda info
```

Checar as informações de `package cache` e `env directories`:

```yaml
package cache : /home/jovyan/work/<projeto>/.conda/pkgs
envs directories : /home/jovyan/work/<projeto>/.conda/envs
```

Criando agora o ambiente com **Python 3.11** e ativando-o (nesse caso não foi preciso instalar o pip, mas vale a pena checar se está instalado):

```sh
conda create --name <projeto> -c conda-forge python=3.11
conda activate <projeto>
python --version
pip --version
```

Configurando **Kernel** para poder utilizar o ambiente instalado no **Jupyter Notebook** (na aba _Launcher_ vai aparecer agora um _Kernel Python (<projeto>)_):

```sh
pip install ipykernel
python -m ipykernel install --user --name <projeto> --display-name "Python (<projeto>)"
```

Instalando pacotes que estão no arquivo `requirements.txt`:

```
pip install -r requirements.txt 
```

Instalando o **Ollama**:

```sh
conda install ollama
```

Para baixar os modelos do **Ollama**, é importante definir o diretório onde serão armazenados.
Criar o diretório dentro da pasta <projeto>:

```
mkdir models
```

Setar uma variável de ambiente que indica para o **Ollama** o diretório dos modelos:

```
export OLLAMA_MODELS=/home/jovyan/work/<projeto>/models
```

Após encerrar a sessão do **Jupyter Notebook*, o que não estiver na pasta do <projeto> será perdido. Para contornar essa situação, use este _script_:

Crie o arquivo `reconfig-ambiente.sh` em <projeto> e edite-o:

```sh
nano reconfig-ambiente.sh
```

Informações no script (substitua <projeto> pelo nome de sua _pasta/projeto_):

```sh
#!/bin/bash

echo "
export OLLAMA_MODELS=/home/jovyan/work/<projeto>/models
export TMPDIR=/home/jovyan/work/<projeto>/tmp

alias <projeto>='conda activate <projeto>'" >> /home/jovyan/.bashrc

cp /home/jovyan/work/<projeto>/.condarc /home/jovyan/

conda activate <projeto>

python -m ipykernel install --user --name <projeto> --display-name "Python (<projeto>)"
```

Conceda permissão para executá-lo:
```
chmod +x reconfig-ambiente.sh
```