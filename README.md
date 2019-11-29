# CentOS xfcnmp

###### 1、对应的文件夹名可以自行修改，本程序仅在 CentOS 7.7 上测试安装成功。

###### 2、文件夹(xfcnmp)建议放在 /srv/ 目录，并改名为 websrv ；所有配置文件关联路径为 /srv/websrv/， 若程序安装在其他目录，请自行修改相关配置文件。

###### 3、程序版本介绍，软件安装包请自行下载，或[下载可安装包](https://pan.baidu.com/s/1i5PA2yT)

```shell
cmake-3.16.0.tar.gz
libmcrypt-2.5.8.tar.gz
libzip-1.5.2.tar.gz
LuaJIT-2.0.5.tar.gz
lua-nginx-module-0.10.15.tar.gz
mcrypt-2.6.8.tar.gz
mhash-0.9.9.9.tar.gz
mysql-boost-5.7.28.tar.gz
nginx-1.16.1.tar.gz
ngx_devel_kit-0.3.1.tar.gz
openssl-1.0.2t.tar.gz
pcre-8.43.tar.gz
php-7.1.33.tar.bz2
redis2-nginx-module-0.15.tar.gz
redis-5.0.5.tar.gz
set-misc-nginx-module-0.32.tar.gz
zlib-1.2.11.tar.gz
```

###### 4、修改 shell 脚本可以执行权限。
```shell
chmod +x /srv/websrv/source/install.sh
```
###### 5、安装命令查看。

```shell
/srv/websrv/source/install.sh --help=1
```

###### 6、安装命令参数解释。

```shell
url_software_base  [安装源码路径, 默认：/srv/websrv/source/] [最后带 /]
url_install_base   [安装程序路径, 默认：/srv/websrv/program/][最后带 /]
url_config_base    [配置文件路径, 默认：/srv/websrv/config/] [最后带 /]
url_data_base      [数据文件路径, 默认：/srv/websrv/data/]   [最后带 /]
is_debug           [0-开始安装；1-查看安装过程命令]
ins_nginx          [1-安装nginx]
ins_mysql          [1-安装mysql]
ins_php            [1-安装php]
ins_redis          [1-安装redis]
```

###### 7、执行安装命令。
   ```shell
/srv/websrv/source/install.sh --url_software_base=/srv/websrv/source/ --url_install_base=/srv/websrv/program/ --url_config_base=/srv/websrv/config/ --url_data_base=/srv/websrv/data/ --is_debug=0 --ins_nginx=1 --ins_mysql=1 --ins_php=1
   ```

###### 8、redis 启动、停止模版，注意 redis.conf 里的 daemonize 值为 yes 和 pidfile 路径：
   ```
/srv/websrv/config/redis/start.sh
/srv/websrv/config/redis/stop.sh
   ```

###### 9、mysql密码：空 或 root。

```shell
# 请自行修改密码：
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
flush privileges;
```

###### 10、php-fpm 启动、停止、重载模版，启动php前请注意修改 /srv/websrv/config/php/php-fpm.conf。

```shell
/srv/websrv/config/php/start.sh
/srv/websrv/config/php/stop.sh
/srv/websrv/config/php/reload.sh
```

###### 11、配置文件可参考此文件夹内 config/ 文件夹里的对应配置；若本程序安装路径为 /srv/websrv/ 可直接覆盖配置文件。

###### 12、更新软件
​    15.1 下载对应程序源码包，注意源码压缩类型；
​    15.2 修改 /install.sh 里对应的软件版本；
​    15.3 mysql 需下载 mysql-boost 版本，同时修改 install.sh 里的 boost_pack_folder 和 mysql_pack_folder。

###### 13、更多版本[下载](https://pan.baidu.com/s/1i5PA2yT)

