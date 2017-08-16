#! /bin/bash
cd `dirname $0`/kcptun
nohup ./client -c kcp_ss.json >/dev/null 2>&1 &  echo $! > `dirname $0`/pid/kcptun.pid