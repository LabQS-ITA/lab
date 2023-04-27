## Ambientes virtuais no Jupyter

### Criar e ativar ambiente virtual

Para usar ambientes virtuais no *Jupyter*, basta abrir a linha de comando no Jupyter e em seguida criar o ambiente virtual com o comando:

```sh
conda create -n <nome do ambiente>
```

Após confirmar com `y`, basta ativar o ambiente e em seguida instalar o utilitário `pip`:

```sh
conda activate flualfa
conda install pip
```

### Usar ambiente virtual

Confirmada a instalação do `pip`, a partir de agora toda instalação de pacote para os notebooks deverá se dar por linha de comando. Por exemplo:

```sh
pip install galeshapley
```

Para confirmar se foi instalado executar `pip list`. Em seguida experimentar com o pacote recém instalado:

```python
from galeshapley import Player
from galeshapley.games import StablePairing

comerciantes = [
    Player(name='Cunha SA'),
    Player(name='Vieira SA'),
    Player(name='Lineu SA'),
    Player(name='Loubach SA'),
]

influenciadores = [
    Player(name='Gildárcio'),
    Player(name='Shigemura'),
    Player(name='Henrique'),
    Player(name='Jean'),
]

cunha, vieira, lineu, loubach = comerciantes
gildarcio, shigemura, henrique, jean = influenciadores

cunha.set_prefs([gildarcio, shigemura, henrique, jean])
vieira.set_prefs([jean, shigemura, gildarcio, henrique])
lineu.set_prefs([shigemura, henrique, gildarcio, jean])
loubach.set_prefs([shigemura, henrique, gildarcio, jean])

gildarcio.set_prefs([cunha, vieira, lineu, loubach])
shigemura.set_prefs([loubach, lineu, cunha, vieira])
henrique.set_prefs([cunha, loubach, vieira, lineu])
jean.set_prefs([vieira, cunha, loubach, lineu])

game = StablePairing(comerciantes, influenciadores)
resultado = game.solve()

print(resultado)
```

### Desativar ambiente virtual

```sh
conda deactivate
```

>*Obs*.: _se executarmos o código acima após desativar o ambiente virtual, o pacote *galeshapley* não será encontrado!

### Remover o ambiente virtual

```sh
conda remove -n flualfa --all
```
