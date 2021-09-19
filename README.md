Personal iPhone photo backup scripts

## Requirements
On Arch Linux

```bash
yay -S ifuse usbmuxd
```

## Mounting iPhone storage

```bash
systemctl status usbmuxd.service
```

```bash
# Device screen must be unlocked
idevicepair pair
```

```bash
mkdir -p /mnt/iphone
sudo ifuse -o allow_other /mnt/iphone
```

## Finding large videos

```bash
find /mnt/iphone -iname '*.MOV' -o -iname '*.MP4' > list.txt
ruby meta_json.rb list.txt > meta.json
ruby meta_analyze.rb meta.json
```

## Backup photos

```bash
rsync -av /mnt/iphone/DCIM /path/to/backup
```

## References
https://wiki.archlinux.org/title/IOS
