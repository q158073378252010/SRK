# 说明
- 需要OSX10.8以上系统
- SS支持AEAD算法及simple-obfs混淆，SSR支持auth_chain_b及以前的混淆，kcptun使用[@xtaci](https://github.com/xtaci/kcptun/releases)预编译版
- 安装目录`$HOME/APP/SRK`
- 请修改`SRK/config`以及`SRK/kcptun`下的配置文件

# 使用方法：
```
 git clone https://github.com/vinewx/SRK.git  
 cd SRK  
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
- 更新PAC：`ss pacupdate` 或者 `ssr pacupdate`

# 卸载：
```
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
 rm -rf $HOME/APP
```

