#!/usr/bin/env bash

# Create separate directory for my repository
if [[ ${1} == "--install" || ${1} == "-i" ]];then
command -v gpg > /dev/null 2>&1 || { echo -e "\nInstalling dependencies..." ;apt update; apt install gnupg -yq --silent; apt upgrade -y;}
decoration() {

	for i in colors.properties termux.properties font.ttf; do
        if [ -f "$HOME/.termux/$i" ];then
        cp $HOME/.termux/$i $HOME/.termux/${i}.bk
        fi
        done

	mkdir -p ~/.termux
	touch $HOME/.termux/configure.bk
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
printf "[?] Do you want TermuxBlack Custom PS1? [Y/n] "
read ask
if [[ "$ask" == [Y/y] ]];then
decoration
fi
addrepo
echo "[i] TermuxBlack Installed Successfully."
# Now trigger broadcast to make changes visible
echo "[i] Now Open New Session & Enjoy (:"
exit 0

# Backup to default settings of your termux. Or Uninstall
elif [[ ${1} == "--uninstall" || ${1} == "-u" ]];then
if [ ! -f "$PREFIX/etc/apt/sources.list.d/termuxblack.list" ];then
echo "[i] TermuxBlack Repository couldn't found !, Make Install First."
exit 0
fi
	rm $PREFIX/etc/apt/sources.list.d/termuxblack.list
if [ -f "$PREFIX/etc/bash.bashrc.bk" ];then
	mv $PREFIX/etc/bash.bashrc.bk $PREFIX/etc/bash.bashrc
fi

if [[ -f "$HOME/.termux/configure.bk" ]];then
	for i in colors.properties termux.properties font.ttf; do
        mv $HOME/.termux/${i}.bk $HOME/.termux/${i}
	done
	rm $HOME/.termux/configure.bk
	am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
fi
	echo "[i] TermuxBlack Uninstalled Successfully."
	exit 0
fi

# Help Menu of termux-black
if [[ ${#@} -gt "0" ]];then
echo -e "
command '$@' is not found

command for usage :
bash $(basename $0) -i : for install termux-black
bash $(basename $0) -u : for uninstall termux-black
"
else
echo -e "
command for usage :
bash $(basename $0) -i : for install termux-black
bash $(basename $0) -u : for uninstall termux-black
"
fi
