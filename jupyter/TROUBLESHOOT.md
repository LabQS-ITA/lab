# NVidia / Jupyter


Se não conseguimos ativar o container Jupyter, pode ser que o sistema operacional tenha atualizado o driver NVidia, o que o torna incompatível com o ambiente. Vamos então remover esta atualização indevida.

Listar o driver:

````
nvidia-smi
````

Se der ERROR, listar os módulos:

```
lsmod | grep nvidia

nvidia_uvm           1216512  0
nvidia_drm             61440  0
nvidia_modeset       1241088  1 nvidia_drm
nvidia              56291328  2 nvidia_uvm,nvidia_modeset
drm_kms_helper        184320  4 mgag200,nvidia_drm
drm                   495616  7 drm_kms_helper,drm_vram_helper,nvidia,mgag200,nvidia_drm,ttm
```

Remover os módulos:

```
sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia_uvm
```

Se não conseguir remover, listar quem está usando:

```
sudo lsof /dev/nvidia*
```

E matar todo mundo, e repetir "Remover os módulos":

```
sudo kill kill kill
```

Confirmar que ficou tudo limpo:

```
lsmod | grep nvidia
```

Testar novamente e em seguinda podemos validar iniciando o container Jupyter:

```
nvidia-smi
```
