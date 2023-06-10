#!/bin/bash

# colors
YELLOW='\033[1;33m';
NOCOLOR='\033[0m';

# download discord tarball 
wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O discord.tar.gz;

if [[ $? != 0 ]]; then
    prinf "${YELLOW}Download Failed${NOCOLOR}\n"
    exit 1;
fi 

if [[ -a /usr/bin/discord ]]; then
	printf  "${YELLOW}WARNING: Discord already installed${NOCOLOR}\n";
	printf "Proceed anyway? [Y/n] ";
	read RESPONSE;

	if [[ $RESPONSE != "y" ]]; then
		exit 1;
	fi
fi

# installation
sudo tar -xvzf discord.tar.gz -C /opt;
sudo ln -sf /opt/Discord/Discord /usr/bin/discord;
sudo cp --remove-destination /opt/Discord/discord.desktop /usr/share/applications;

sudo sed -i "s+Exec*+Exec=/usr/bin/discord\n+" /usr/share/applications/discord.desktop;
sudo sed -i "s/Icon*/Icon=\/opt\/Discord\/discord.png/\n" /usr/share/applications/discord.desktop;

rm discord.tar.gz

# if present, prompt the user if discord post install script should be run
if [[ -a /opt/Discord/postinst.sh ]]; then
	less /opt/Discord/postinst.sh;

	printf "run postinst.sh? [Y/n] "
	read RESPONSE;

	if [[ $RESPONSE == "y" ]]; then
		. /opt/Discord/postinst.sh;
	fi
fi

exit 0;

