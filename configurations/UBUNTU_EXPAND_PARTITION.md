For some reason Ubuntu does not use the whole partition while installing the OS, at least when doing it in a VM.

Target parition to expand is `ubuntu--vg-ubuntu--lv`

1. Confirm current paritions - `df -h`
2. Confirm parition to expand is smaller than available space - `lsblk`
3. Expand the parition
     1. `vgdisplay`
     2. `sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv`
     3. `resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv`

Reference: https://askubuntu.com/a/1330709
