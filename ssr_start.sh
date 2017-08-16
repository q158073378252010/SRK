#! /bin/bash
DIR=$HOME/APP/SRK
DAEMON=$DIR/shadowsocks/local.py
CONF=$DIR/config/ssr_client.json
python $DAEMON --pid-file $DIR/pid/shadowsocksr.pid --log-file=$DIR/shadowsocksr.log -c $CONF -d start