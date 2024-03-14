#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="alis-lxqt-ja"
iso_label="ALIS_2404L"
iso_publisher="NakamuraJukebox"
iso_application="Alis Installation Drive"
iso_version="24.04"
install_dir="alis"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.grub.esp' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/usr/local/bin/alisfirstrun.sh"]="0:0:755"
)
