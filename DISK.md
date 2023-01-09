# Adicionar discos aos servidores


### Mostrar discos físicos

```sh
sudo pvs
```
resultado:
> ```sh
>  PV         VG        Fmt  Attr PSize    PFree
>  /dev/sda3  ubuntu-vg lvm2 a--  <277.36g    0
> ```


### Achar o disco novo

```sh
sudo fdisk -l
```
resultado:
> ```sh
> . . .
>
> Disk /dev/sda: 279.37 GiB, 299966445568 bytes, 585871964 sectors
> Disk model: LOGICAL VOLUME
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: AB308443-641B-4113-9A5E-D3CF80FC345A
>
> Device       Start       End   Sectors   Size Type
> /dev/sda1     2048      4095      2048     1M BIOS boot
> /dev/sda2     4096   4198399   4194304     2G Linux filesystem
> /dev/sda3  4198400 585869311 581670912 277.4G Linux filesystem
> GPT PMBR size mismatch (1172123567 != 1172058031) will be corrected by write.
> 
> 
> Disk /dev/sdb: 558.88 GiB, 600093712384 bytes, 1172058032 sectors
> Disk model: LOGICAL VOLUME
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x00000000
> 
> Device     Boot Start        End    Sectors   Size Id Type
> /dev/sdb1           1 1172058031 1172058031 558.9G ee GPT
> 
> 
> Disk /dev/mapper/ubuntu--vg-ubuntu--lv: 277.36 GiB, 297812361216 bytes, 581664768 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> . . .
> ```


### Criar volume físico

> Obs.: se já existir uma partição, usar fdisk para excluí-la

```sh
sudo pvcreate /dev/sdb
```
resultado
> ```sh
>   Physical volume "/dev/sdb" successfully created.
> ```

> Obs.: um alerta pode ser emitido caso uma partição tenha sido criada anteriormente
> ```
> WARNING: dos signature detected on /dev/sdb at offset 510. Wipe it? [y/n]: y
>   Wiping dos signature on /dev/sdb.
> ```


### Adicionar o volume físico ao grupo

```sh
sudo vgextend ubuntu-vg /dev/sdb
```
resultado
> ```sh
>   Volume group "ubuntu-vg" successfully extended
> ```


### Extender o volume lógico

```sh
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
```
resultado
> ```sh
>   Size of logical volume ubuntu-vg/ubuntu-lv changed from <277.36 GiB (71004 extents) to <836.24 GiB (214077 extents).
>   Logical volume ubuntu-vg/ubuntu-lv successfully resized.
> ```


### Ajustar tamanho do sistema de arquivos

```sh
sudo resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv
```
resultado
> ```sh
> resize2fs 1.46.5 (30-Dec-2021)
> Filesystem at /dev/mapper/ubuntu--vg-ubuntu--lv is mounted on /; on-line resizing required
> old_desc_blocks = 35, new_desc_blocks = 105
> The filesystem on /dev/mapper/ubuntu--vg-ubuntu--lv is now 219214848 (4k) blocks long.
> ```
