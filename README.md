1、对应的文件夹名可以自行修改，本程序仅在 CentOS 7.1 上测试通过。

2、文件夹(xfcnmp)建议放在 /srv/ 目录，并改名为 websrv ；所有配置文件关联路径为 /srv/websrv/， 若程序安装在其他目录，请自行修改相关配置文件。

3、修改 shell 脚本可以执行权限。
    chmod +x /srv/websrv/source/install.sh

4、安装命令查看。
    /srv/websrv/source/install.sh --help=1

5、安装命令参数解释。
    url_software_base  [安装源码路径, 默认：/srv/websrv/source/] [最后带 /]
    url_install_base   [安装程序路径, 默认：/srv/websrv/program/][最后带 /]
    url_config_base    [配置文件路径, 默认：/srv/websrv/config/] [最后带 /]
    url_data_base      [数据文件路径, 默认：/srv/websrv/data/]   [最后带 /]
    is_debug           [0-开始安装；1-查看安装过程命令]
    ins_nginx          [1-安装nginx]
    ins_mysql          [1-安装mysql]
    ins_php            [1-安装php]
    ins_pureftpd       [1-安装ftp]
    ins_redis          [1-安装redis]
    ins_subversion     [1-安装svn]
    ins_php_memcache   [1-安装php_memcache]
    ins_memcached      [1-安装memcached]

6、执行安装命令。
    /srv/websrv/source/install.sh --url_software_base=/srv/websrv/source/ --url_install_base=/srv/websrv/program/ --url_config_base=/srv/websrv/config/ --url_data_base=/srv/websrv/data/ --is_debug=0 --ins_nginx=1 --ins_mysql=1 --ins_php=1

7、程序版本介绍，详细查看 /srv/websrv/source/ 下文件。
    nginx-1.10.1
    mysql-5.7.15
    php-7.0.11
    pure-ftpd-1.0.36
    subversion-1.8.15

8、php-fpm.conf 文件路径默认为 /srv/websrv/config/php/php-fpm.conf 。

9、pure-ftpd 启动、关闭模版：
    /srv/websrv/config/pureftpd/start.sh
    /srv/websrv/config/pureftpd/stop.sh

10、redis 启动、停止模版，注意 redis.conf 里的 daemonize 值为 yes 和 pidfile 路径：
    /srv/websrv/config/redis/start.sh
    /srv/websrv/config/redis/stop.sh

11、memcached 启动、停止模版：
    /srv/websrv/config/memcached/start.sh
    /srv/websrv/config/memcached/stop.sh

12、mysql密码：空 或 root。
    请自行修改密码：
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
    flush privileges;

13、php-fpm 启动、停止、重载模版，启动php前请注意修改 /srv/websrv/config/php/php-fpm.conf。
    /srv/websrv/config/php/start.sh
    /srv/websrv/config/php/stop.sh
    /srv/websrv/config/php/reload.sh

14、配置文件可参考此文件夹内 config/ 文件夹里的对应配置；若本程序安装路径为 /srv/websrv/ 可直接覆盖配置文件。

15、更新软件
    15.1 下载对应程序源码包，注意源码压缩类型；
    15.2 修改 /install.sh 里对应的软件版本；
    15.3 mysql 需下载 mysql-boost 版本，同时修改 install.sh 里的 boost_pack_folder 和 mysql_pack_folder。

16、更多版本[下载](http://pan.baidu.com/s/1sk0AYVN#path=%252Fsoftware%252Fweb_tool)
