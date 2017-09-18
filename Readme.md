# 说明
- 需要OSX10.8以上系统
- SS支持AEAD算法及simple-obfs混淆，SSR支持auth_chain_b及以前的混淆，kcptun使用[@xtaci](https://github.com/xtaci/kcptun/releases)预编译版, VR使用[@v2ray](https://github.com/v2ray/v2ray-core/releases)预编译版
- 安装目录`$HOME/APP/SRK`
- 请修改`SRK/config`、`SRK/kcptun`以及`SRK/v2ray`下的配置文件

# 使用方法：
```
 curl -LO https://github.com/vinewx/SRK/archive/dev.zip
 unzip dev.zip && rm dev.zip
 cd SRK-dev
 bash install.sh
```

# 启动客户端：

- 启动SS：`ss start`
- 停止SS：`ss stop`
- 重启SS：`ss restart`
- SS客户端状态：`ss status`

- 启动SSR：`ssr start`
- 停止SSR：`ssr stop`
- 重启SSR：`ssr restart`
- SSR客户端状态：`ssr status`

- 启动VR：`vr start`
- 停止VR：`vr stop`
- 重启VR：`vr restart`
- VR客户端状态：`vr status`
- VR日志：`vr log`

- 更新PAC：`ss pacupdate` 或者 `ssr pacupdate` 或者 `vr pacupdate`

脚本自带pac，请将自动代理配置设置为：http://127.0.0.1:8888/proxy.pac


# 卸载：
```
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
 rm -rf $HOME/APP
```

