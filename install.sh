#!/bin/bash

# colors
YELLOW='\033[1;33m';
NOCOLOR='\033[0m';


install () {
	sudo tar -xvzf $1 -C /opt;
	sudo ln -sf /opt/Discord/Discord /usr/bin/discord;
	sudo cp -r /opt/Discord/discord.desktop /usr/share/applications;

	printf "Remove $1? [Y/n] ";
	read RESPONSE;

	if [[ $RESPONSE == "y" ]]; then
		rm $1;
	fi
}

if [[ -a /usr/bin/discord ]]; then
	printf  "${YELLOW}WARNING: Discord already installed${NOCOLOR}\n";
	printf "Proceed anyway? [Y/n] ";
	read RESPONSE;

	if [[ $RESPONSE == "y" ]]; then
		printf "Re-installing Discord...\n"
		install;
	fi
else
	install;
fi

