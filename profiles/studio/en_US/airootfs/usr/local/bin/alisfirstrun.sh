#!/bin/bash

LAYOUT=$(localectl | sed -n 3p | sed -e "s/X11 Layout://g" | sed 's/^ *\| *$//')

# only works on gnome
#sed -e s/"'xkb', '.*'"/"'xkb', '$LAYOUT'"/g -i /etc/dconf/db/local.d/00-default
#dconf update

sed -e s/"Default Layout=.*"/"Default Layout=$LAYOUT"/g -i /usr/share/alislinux/fcitx5-profile
sed -e s/"DefaultIM=.*"/"DefaultIM=anthy"/g -i /usr/share/alislinux/fcitx5-profile
sed -e s/"Name=keyboard-.*"/"Name=keyboard-$LAYOUT"/g -i /usr/share/alislinux/fcitx5-profile

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
