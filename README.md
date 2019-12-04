# CentOS xfcnmp

#### 1、对应的文件夹名可以自行修改，本程序仅在64位系统 CentOS 7.4 和 CentOS 7.7 上测试安装成功。

#### 2、文件夹(xfcnmp)建议放在 /srv/ 目录 ；所有配置文件关联路径为 /srv/websrv/， 若程序安装在其他目录，请自行修改相关配置文件。

#### 3、程序版本介绍，软件安装包请自行下载（放到 xfcnmp/source/ 目录），或[下载完整安装包](https://pan.baidu.com/s/1i5PA2yT#list/path=%2Fsharelink2958561331-535926987262596%2Fweb_tool%2Fcentos&parentPath=%2Fsharelink2958561331-535926987262596)

###### 3.1 主要安装软件

mysql-5.7.28

nginx-1.16.1

php-7.3.12

redis-5.0.7

###### 3.2 完整文件名及相关依赖软件

[cmake-3.16.0.tar.gz](https://cmake.org/download/)

[libmcrypt-2.5.8.tar.gz](https://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz)

[libzip-1.5.2.tar.gz](https://libzip.org/download/libzip-1.5.2.tar.gz)

[luajit2-2.1-20190912](https://github.com/openresty/luajit2)

[lua-resty-core-0.1.17](https://github.com/openresty/lua-resty-core)

[lua-resty-lrucache-0.09](https://github.com/openresty/lua-resty-lrucache)

[lua-nginx-module-0.10.15.tar.gz](https://github.com/openresty/lua-nginx-module)

[mcrypt-2.6.8.tar.gz](https://nchc.dl.sourceforge.net/project/mcrypt/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz)

[mhash-0.9.9.9.tar.gz](https://nchc.dl.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz)

[mysql-boost-5.7.28.tar.gz](https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-boost-5.7.28.tar.gz)

[nginx-1.16.1.tar.gz](http://nginx.org/download/nginx-1.16.1.tar.gz)

[ngx_devel_kit-0.3.1.tar.gz](https://github.com/simplresty/ngx_devel_kit)

[openssl-1.0.2t.tar.gz](https://www.openssl.org/source/openssl-1.0.2t.tar.gz)

[pcre-8.43.tar.gz](https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz)

[php-7.3.12.tar.gz](https://www.php.net/downloads.php)

[redis2-nginx-module-0.15.tar.gz](https://github.com/openresty/redis2-nginx-module)

[redis-5.0.7.tar.gz](http://download.redis.io/releases/redis-5.0.7.tar.gz)

[set-misc-nginx-module-0.32.tar.gz](https://github.com/openresty/set-misc-nginx-module)

[zlib-1.2.11.tar.gz](http://www.zlib.net/zlib-1.2.11.tar.gz)



#### 4、修改 shell 脚本可以执行权限。
```shell
$ sudo chmod +x /srv/xfcnmp/source/install.sh
```
#### 5、安装命令参考查看（注意实际路径）。

```shell
$ sudo /srv/xfcnmp/source/install.sh --help=1
```

#### 6、安装命令参数说明。

```shell
url_software_base  [安装源码路径, 默认：/srv/websrv/source/] [最后带 /]
url_install_base   [安装程序路径, 不写则默认：/srv/websrv/program/][最后带 /]
url_config_base    [配置文件路径, 不写则默认：/srv/websrv/config/] [最后带 /]
url_data_base      [数据文件路径, 不写则默认：/srv/websrv/data/]   [最后带 /]
is_debug           [0-开始安装；1-查看安装过程命令]
ins_nginx          [1-安装nginx]
ins_mysql          [1-安装mysql]
ins_php            [1-安装php]
ins_redis          [1-安装redis]
```

#### 7、安装命令参考。
   ```shell
# 下载完整安装包：
$ sudo cp xfcnmp_p7.3.12.tar.gz /srv/
$ cd /srv/
$ sudo tar -zxf xfcnmp_p7.3.12.tar.gz
$ sudo /srv/xfcnmp/source/install.sh --url_software_base=/srv/xfcnmp/source/ --url_install_base=/srv/websrv/program/ --url_config_base=/srv/websrv/config/ --url_data_base=/srv/websrv/data/ --ins_nginx=1 --ins_mysql=1 --ins_php=1 --ins_redis=0 --is_debug=0
   ```

#### 8、redis 启动、停止模版，注意 redis.conf 里的 daemonize 值为 yes 和 pidfile 路径：
   ```shell
$ sudo /srv/websrv/config/redis/start.sh
$ sudo /srv/websrv/config/redis/stop.sh
   ```

#### 9、MySQL账号：root；密码：空；注意及时修改。

```shell
# 请自行修改密码：
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
flush privileges;
```

#### 10、php-fpm 启动、停止、重载模版，启动 php 前请注意修改 /srv/websrv/config/php/7.3/php-fpm.conf。

```shell
$ sudo /srv/websrv/config/php/7.3/start.sh
$ sudo /srv/websrv/config/php/7.3/stop.sh
$ sudo /srv/websrv/config/php/7.3/reload.sh
```

#### 11、总启动脚本模板，注意修改 php 版本。

```shell
$ sudo /srv/websrv/config/start_websrv.sh
$ sudo /srv/websrv/config/stop_websrv.sh
```

#### 12、配置文件可参考此文件夹内 config/ 文件夹里的对应配置；若本程序安装路径为 /srv/websrv/ 可直接覆盖配置文件。

#### 13、更新软件
​    13.1 下载对应程序源码包（放到 xfcnmp/source/ 目录），注意源码压缩类型；

​    13.2 修改 /install.sh 里对应的软件版本；

​    13.3 mysql 需下载 mysql-boost 版本，同时修改 install.sh 里的 boost_pack_folder 和 mysql_pack_folder；

​	13.4 php 支持7.1，7.2，7.3；暂不支持7.4，同时修改 install.sh 里的 php_pack_folder 和 php_version。

#### 14、更多版本[下载](https://pan.baidu.com/s/1i5PA2yT)

