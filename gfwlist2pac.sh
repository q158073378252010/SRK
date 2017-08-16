#!/bin/bash
### BEGIN INIT INFO
# Provides:          gfwlist2pac
# Description:       update pac file
### END INIT INFO

# Author: vinew.cc


GFWLIST="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
PROXY="127.0.0.1:1080"
USER_RULE_NAME="user-rule.txt"

check_module_installed()
{
	pip list | grep gfwlist2pac &> /dev/null

	if [ $? -eq 1 ]; then
		echo "Installing gfwlist2pac."

		sudo pip install gfwlist2pac
	fi
}

update_gfwlist()
{
	echo "Downloading gfwlist."

	curl -s "$GFWLIST" --fail --socks5-hostname "$PROXY" --output /tmp/gfwlist.txt

	if [[ $? -ne 0 ]]; then
		echo "abort due to error occurred."
    exit 1
	fi

	cd $HOME/APP/SRK/pac || exit 1

	if [ -f "proxy.pac" ]; then
		mv proxy.pac ~/.Trash
	fi

	if [ ! -f $USER_RULE_NAME ]; then
		touch $USER_RULE_NAME
	fi

	/usr/local/bin/gfwlist2pac \
    --input /tmp/gfwlist.txt \
    --file proxy.pac \
    --proxy "SOCKS5 $PROXY; SOCKS $PROXY; DIRECT" \
    --user-rule $USER_RULE_NAME \
    --precise

  rm -f /tmp/gfwlist.txt

  echo "Updated."
}

check_module_installed
update_gfwlist