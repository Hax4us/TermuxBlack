#!/usr/bin/env sh

# Create separate directory for my repository
if [[ ${1} == "--install" || ${1} == "-i" ]];then
command -v gpg > /dev/null 2>&1 || { echo -e "\nInstalling dependencies..." ;apt update; apt install gnupg -yq --silent;}
decoration() {

	for i in colors.properties termux.properties font.ttf; do
        if [ -f "$HOME/.termux/$i" ];then
        cp $HOME/.termux/$i $HOME/.termux/${i}.bk
        fi
        done

	mkdir -p ~/.termux
	for i in colors.properties termux.properties font.ttf; do
		wget -q https://github.com/Hax4us/TermuxBlack/raw/master/style/$i -O ~/.termux/$i
	done
	#rm -r $PREFIX/etc/motd
	#echo "toilet -F metal -F border -f future termux black" >> $PREFIX/etc/bash.bashrc
	cp $PREFIX/etc/bash.bashrc $PREFIX/etc/bash.bashrc.bk
	sed -i s:PS1.*:"PS1=\'\\\\[\\\\e\[1\;34m\\\\]termuxblack > \\\[\\\e[0;37m\\\\]\'": $PREFIX/etc/bash.bashrc
	am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
	}

addrepo() {
	# Add repo in separate file
	mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://hax4us.github.io/TermuxBlack/ termuxblack main" > $PREFIX/etc/apt/sources.list.d/termuxblack.list

	# Add gpg public key
	wget -q https://hax4us.github.io/TermuxBlack/termuxblack.key -O termuxblack.key && apt-key add termuxblack.key
	
	# just update
	apt-get update -yq --silent
}

echo "[i] Installing TermuXBlacK ..."
printf "Are you want TermuxBlack Custom PS1? [Y/n] "
read ask
if [[ "$ask" == [Y/y] ]];then
decoration
fi
addrepo
echo "[i] TermuxBlack Installed Successfully."
# Now trigger broadcast to make changes visible
echo "[i] Now open new session & enjoy"

# Backup to default settings of your termux.
elif [[ ${1} == "--uninstall" || ${1} == "-u" ]];then
	rm $PREFIX/etc/apt/sources.list.d/termuxblack.list
	mv $PREFIX/etc/bash.bashrc.bk $PREFIX/etc/bash.bashrc
	for i in colors.properties termux.properties font.ttf; do
        if [ -f "$HOME/.termux/$i" ];then
        mv $HOME/.termux/${i}.bk $HOME/.termux/${i}
        fi
        done
	am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
	echo "[i] TermuxBlack Uninstalled Successfully."
fi
