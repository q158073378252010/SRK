#! /bin/bash
cd `dirname $0`/pac
nohup python -m SimpleHTTPServer 8888 >/dev/null 2>&1 & echo $! > `dirname $0`/pid/pac.pid