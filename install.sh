#!/bin/bash
### BEGIN INIT INFO
# Provides:          ss & ssr & vr & kcptun
### END INIT INFO

# Author: vinew.cc
mkdir $HOME/APP
mv $PWD $HOME/APP/SRK
DIR=$HOME/APP/SRK
osx_vers=$(sw_vers -productVersion | awk -F "." '{print $2}')
cmd_line_tools_temp_file="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

check_CommandLineTools()
{
 if [[ "$osx_vers" -eq 8 ]]; then
   which gcc &> /dev/null
     if [ $? -eq 1 ]; then
	  echo -e "\033[41;37m Installing CommandLineTools. \033[0m"
		DMGURL=http://devimages.apple.com/downloads/xcode/command_line_tools_for_osx_mountain_lion_april_2014.dmg
		TOOLS=cltools.dmg
		curl "$DMGURL" -o "$TOOLS"
		TMPMOUNT=`/usr/bin/mktemp -d /tmp/clitools.XXXX`
		hdiutil attach "$TOOLS" -mountpoint "$TMPMOUNT" -nobrowse
		sudo installer -allowUntrusted -pkg "$(find $TMPMOUNT -name '*.mpkg')" -target /
		hdiutil detach "$TMPMOUNT"
		rm -rf "$TMPMOUNT"
		rm "$TOOLS"
	 which git &> /dev/null
       if [ $? -eq 1 ]; then
	      echo -e "\033[41;37m CommandLineTools installed failed. \033[0m"
	    exit 1
       fi
	  else
        echo -e "\033[41;37m Command Line Tools is already installed. \033[0m"
      fi
	  else
	    if [ ! -d /Library/Developer/CommandLineTools ]; then
        xcode-select --install
        if [ ! -d /Library/Developer/CommandLineTools ]; then
        echo -e "\033[41;37m CommandLineTools installed failed. \033[0m"
        fi
        else
        echo -e "\033[41;37m Command Line Tools is already installed. \033[0m"
        fi    
 fi       
}

check_installed()
{
which brew &> /dev/null
   if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing brew. \033[0m"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [ $? -eq 1 ]; then
		echo -e "\033[41;37m brew installed failed. \033[0m"
		exit 1
	    fi
	  else
	  	echo -e "\033[41;37m Howebrew is already installed. \033[0m"

	fi
   
which ss-local &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing Shadowsocks-libev. \033[0m"
        brew install shadowsocks-libev
        if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Shadowsocks-libev installed failed. \033[0m"
		exit 1
	    fi
	  else
	  	echo -e "\033[41;37m Shadowsocks-libev is already installed. \033[0m"

	fi

which obfs-local &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing simple-obfs. \033[0m"
        brew install simple-obfs
        if [ $? -eq 1 ]; then
		echo -e "\033[41;37m simple-obfs installed failed. \033[0m"
		exit 1
	    fi
	  else
	  	echo -e "\033[41;37m simple-obfs is already installed. \033[0m"

	fi

which pip &> /dev/null
    if [ $? -eq 1 ]; then
		echo -e "\033[41;37m Installing pip. \033[0m"
        sudo easy_install pip
        if [ $? -eq 1 ]; then
		echo -e "\033[41;37m pip installed failed. \033[0m"
		exit 1
	    fi
	  else
	  	echo -e "\033[41;37m pip is already installed. \033[0m"

	fi

if [ ! -d shadowsocks ]; then
    git clone https://github.com/gfwbak/shadowsocksr.git
      mv shadowsocksr/shadowsocks shadowsocks
      rm -rf shadowsocksr
      if [ $? -ne 0 ]; then
               echo -e "\033[41;37m ShadowsocksR installed failed \033[0m"
               exit 1
           fi
          else
               echo -e "\033[41;37m shadowsocksr is already installed. \033[0m"
fi

}

handle_file()
{
	ln $DIR/bin/* /usr/local/bin
	
	kcp=$( curl -s https://api.github.com/repos/xtaci/kcptun/releases/latest | grep browser_download_url | grep 'darwin-amd64-[0-9]*.tar.gz' | head -n 1 | cut -d '"' -f 4 )
    curl -L $kcp -o kcptun.tar.gz
	if [ $? -ne 0 ]; then
		echo -e "\033[41;37m kcptun installed failed \033[0m"
        exit 1
    fi
    tar xvf kcptun.tar.gz
    mv client_darwin_amd64 kcptun/client
    rm -rf kcptun.tar.gz server_darwin_amd64

    vr=$( curl -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | grep browser_download_url | grep 'macos[.]zip' | head -n 1 | cut -d '"' -f 4 )
    curl -L $vr -o v2ray.zip
	if [ $? -ne 0 ]; then
		echo -e "\033[41;37m kcptun installed failed \033[0m"
        exit 1
    fi
    unzip v2ray.zip "*/v2ray" && rm v2ray.zip && mv v2ray* v2ray
    chmod 755 v2ray/v2ray
    echo 请修改自行本配置文件 > v2ray/config.json
}

check_CommandLineTools
check_installed
handle_file
echo -e "\033[41;37m enjoy! \033[0m"

