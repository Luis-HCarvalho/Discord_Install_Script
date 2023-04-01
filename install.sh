#!/bin/bash

# colors
YELLOW='\033[1;33m';
NOCOLOR='\033[0m';

PARAM1=$1;

install () {
	sudo tar -xvzf $PARAM1 -C /opt;
	sudo ln -sf /opt/Discord/Discord /usr/bin/discord;
	sudo cp -r /opt/Discord/discord.desktop /usr/share/applications;

	printf "Remove ${PARAM1}? [Y/n] ";
	read RESPONSE;

	if [[ $RESPONSE == "y" ]]; then
		rm $PARAM1;
	fi
}

if ! [[ $PARAM1  ]]; then
	exit 1;
else
	echo "$PARAM1";
fi

if [[ -a /usr/bin/discord ]]; then
	printf  "${YELLOW}WARNING: Discord already installed${NOCOLOR}\n";
	printf "Proceed anyway? [Y/n] ";
	read RESPONSE;

	if [[ $RESPONSE == "y" ]]; then
		install;
	fi
else
	install;
fi

exit 0;

