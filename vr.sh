#! /bin/bash
cd `dirname $0`/v2ray
nohup ./v2ray -config config.json >v2ray.log &  echo $! > `dirname $0`/pid/v2ray.pid