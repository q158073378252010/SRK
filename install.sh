#!/bin/bash
### BEGIN INIT INFO
# Provides:          ss & ssr & kcptun
### END INIT INFO

# Author: vinew.cc
mkdir $HOME/APP
mv $PWD $HOME/APP
DIR=$HOME/APP/SRK

check_installed()
{
if [ ! -d /Library/Developer/CommandLineTools ]; then
	  echo -e "\033[41;37m Installing Command Line Tools. \033[0m"
      xcode-select --install
    else
      echo -e "\033[41;37m Command Line Tools is already installed. \033[0m"
fi

which brew &> /dev/null
   if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing brew. \033[0m"
        usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	  else
	  	echo -e "\033[41;37m Howebrew is already installed. \033[0m"

	fi

which wget &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing wget. \033[0m"
        brew install wget
	  else
	  	echo -e "\033[41;37m wget is already installed. \033[0m"

	fi
   
which ss-local &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing Shadowsocks-libev. \033[0m"
        brew install shadowsocks-libev
	  else
	  	echo -e "\033[41;37m Shadowsocks-libev is already installed. \033[0m"

	fi

which obfs-local &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing simple-obfs. \033[0m"
        brew install simple-obfs
	  else
	  	echo -e "\033[41;37m simple-obfs is already installed. \033[0m"

	fi

which pip &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing pip. \033[0m"
        sudo easy_install pip
	  else
	  	echo -e "\033[41;37m pip is already installed. \033[0m"

	fi

if [ ! -d shadowsocks ]; then
    svn co https://github.com/gfwbak/shadowsocksr/trunk/shadowsocks
    if [ $? -ne 0 ]; then
        echo -e "\033[41;37m ShadowsocksR installed failed \033[0m"
        exit 1
    fi
fi

}

handle_file()
{
	ln $DIR/bin/ss /usr/local/bin/ss
	ln $DIR/bin/ssr /usr/local/bin/ssr
	
	wget -N --no-check-certificate https://github.com/xtaci/kcptun/releases/download/v20170525/kcptun-darwin-amd64-20170525.tar.gz
	if [ $? -ne 0 ]; then
		echo -e "\033[41;37m kcptun installed failed \033[0m"
        exit 1
    fi
    tar xvf kcptun-darwin-amd64-20170525.tar.gz
    mv client_darwin_amd64 kcptun/client
    rm -rf kcptun-darwin-amd64-20170525.tar.gz server_darwin_amd64
}

check_installed
handle_file
echo -e "\033[41;37m enjoy! \033[0m"

