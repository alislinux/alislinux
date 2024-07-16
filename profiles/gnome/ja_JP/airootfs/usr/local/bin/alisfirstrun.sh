#!/bin/bash

LAYOUTS=($(localectl | grep "X11 Layout" | sed -e "s/X11 Layout://g" | sed 's/^ *\| *$//' | sed "s/,/ /g"))
NUM=$((${#LAYOUTS[@]} - 1))

# only works on gnome
sed -e s/"'xkb', '.*'"/"'xkb', '${LAYOUTS[${NUM}]}'"/g -i /etc/dconf/db/local.d/00-default
dconf update

sed -e s/"Default Layout=.*"/"Default Layout=${LAYOUTS[${NUM}]}"/g -i /usr/share/alislinux/fcitx5-profile
sed -e s/"DefaultIM=.*"/"DefaultIM=anthy"/g -i /usr/share/alislinux/fcitx5-profile
sed -e s/"Name=keyboard-.*"/"Name=keyboard-${LAYOUTS[${NUM}]}"/g -i /usr/share/alislinux/fcitx5-profile

homedir="/home/*"
dirs=`find $homedir -maxdepth 0 -type d`

for dir in $dirs;
do
	user=${dir:6}
	if [ ! -d ${dir}/.config/fcitx5 ]; then
		mkdir -p ${dir}/.config/fcitx5
	fi
	cp /usr/share/alislinux/fcitx5-profile $dir/.config/fcitx5/profile
	chown -R $user:$user $dir
	chown -R $user:$user $dir/.config/fcitx5/profile
done

if [ ! -d /etc/skel/.config/fcitx5 ]; then
	mkdir -p /etc/skel/.config/fcitx5
fi
cp /usr/share/alislinux/fcitx5-profile /etc/skel/.config/fcitx5/profile

systemctl disable alisfirstrun.service
