#!/bin/sh

##------------------------------------------------------------------------------
##获取shell颜色
function get_shl_color(){
    local color="0";
    case $1 in
        red) color="1";       ##红
        ;;
        green) color="2";     ##绿
        ;;
        yellow) color="3";    ##黄
        ;;
        blue) color="4";      ##蓝
        ;;
        purple) color="5";    ##紫
        ;;
        blues) color="6";     ##青
        ;;
        *) color="0";         ##默认
        ;;
    esac
    return $color;
}
##获取shell样式
function get_shl_style(){
    local style="3";
    case $1 in
        _) style="2"; ##下划线
        ;;
        b) style="4"; ##背景
        ;;
        *) style="3"; ##无
        ;;
    esac
    return $style;
}
## 输出不换行
function get_style(){
    local color="0",style="4",style_color="0";
    get_shl_color "$1";
    color=$?;
    get_shl_color "$2";
    style_color=$?;
    get_shl_style "$3";
    style=$?;
    echo -n -e "\033[${style}${style_color};3${color}""m";
}
## 输出不换行
function print(){
    if [ "" != "$2" ]; then
        get_style "$2" "$3" "$4";
    fi
    echo -n -e "$1""\033[0m";
}
## 输出换行
function println(){
    if [ "" != "$2" ]; then
        get_style "$2" "$3" "$4";
    fi
    echo -e "$1""\033[0m";
}
## 执行命令
function shl_exec(){
    eval "$1";
}
## 终止退出
function shl_exit(){
    exit;
}
##------------------------------------------------------------------------------
##解析参数
function to_argv(){
    OLD_IFS="$IFS";
    IFS=" ";
    arr=($argvs);
    IFS="$OLD_IFS";
    for tmp in ${arr[@]};
    do
        lastvar='';
        IFS="=";
        arr_tmp=($tmp);
        IFS="$OLD_IFS";
        for tmps in ${arr_tmp[@]};
        do
            if [ '' == "$lastvar" ]; then
                lastvar=`echo $tmps|awk '{print substr($0, 3)}'`;
            else
                shl_exec ${lastvar}="'${tmps}'";
            fi
        done
    done
}
##------------------------------------------------------------------------------
argvs=$*;
clear
help=0;
ins_cmake=0;
ins_libmcrypt=0;
ins_libzip=0;
ins_mcrypt=0;
ins_mhash=0;
ins_mysql=0;
ins_nginx=0;
ins_openssl=0;
ins_pcre=0;
ins_php=0;
ins_php_redis=0;
ins_redis=0;
ins_zlib=0;
is_debug=1;    #是否调试模式[1-是,0-否]

##------------------------------------------------------------------------------
println "********************************************************************************" yellow;
println "CONFIGURE CENTOS SERVER";
println "********************************************************************************\n" yellow;
shl_cmd="yum -y install gcc gcc-c++ make bzip2";
url_software_base="/srv/websrv/source/";        ## 安装程序路径
url_install_base="/srv/websrv/program/";        ## 安装结果路径
url_config_base="/srv/websrv/config/";          ## 配置文件路径
url_data_base="/srv/websrv/data/";              ## 安装数据路径
url_sbin_base="/usr/bin/";                      ## 系统执行命令路径
to_argv;
url_path_base="$(dirname $url_install_base)/";  ## 安装程序根目录

##软件名称和源码路径,更新软件版本时修改此处-------------------------------------
cmake_pack_folder="cmake-3.16.0";
libzip_pack_folder="libzip-1.5.2";
openssl_pack_folder="openssl-1.0.2t";
pcre_pack_folder="pcre-8.43";
zlib_pack_folder="zlib-1.2.11";

boost_pack_folder="mysql-boost-5.7.28";
mysql_pack_folder="mysql-5.7.28";

nginx_pack_folder="nginx-1.16.1";
lua_mod_pack_folder="lua-nginx-module-0.10.15";
luajit_pack_folder="luajit2-2.1-20190912";
lua_resty_core_pack_folder="lua-resty-core-0.1.17";
lua_resty_lrucache_pack_folder="lua-resty-lrucache-0.09";
misc_mod_pack_folder="set-misc-nginx-module-0.32";
ngx_devel_kit_pack_folder="ngx_devel_kit-0.3.1";
redis_mod_pack_folder="redis2-nginx-module-0.15";

php_pack_folder="php-7.3.12";
php_version="7.3";
php_redis_pack_folder="phpredis-5.1.1";
libmcrypt_pack_folder="libmcrypt-2.5.8";
mcrypt_pack_folder="mcrypt-2.6.8";
mhash_pack_folder="mhash-0.9.9.9";
redis_pack_folder="redis-5.0.7";

cmake_pack_name="${cmake_pack_folder}.tar.gz";
libzip_pack_name="${libzip_pack_folder}.tar.gz";
openssl_pack_name="${openssl_pack_folder}.tar.gz";
pcre_pack_name="${pcre_pack_folder}.tar.gz";
zlib_pack_name="${zlib_pack_folder}.tar.gz";

## MYSQL ---------------
mysql_pack_name="${boost_pack_folder}.tar.gz";
## / MYSQL ---------------

## nginx 模块---------------
nginx_pack_name="${nginx_pack_folder}.tar.gz";
lua_mod_pack_name="${lua_mod_pack_folder}.tar.gz";
luajit_pack_name="${luajit_pack_folder}.tar.gz";
lua_resty_lrucache_pack_name="${lua_resty_lrucache_pack_folder}.tar.gz";
lua_resty_core_pack_name="${lua_resty_core_pack_folder}.tar.gz";
misc_mod_pack_name="${misc_mod_pack_folder}.tar.gz";
ngx_devel_kit_pack_name="${ngx_devel_kit_pack_folder}.tar.gz";
redis_mod_pack_name="${redis_mod_pack_folder}.tar.gz";
## / nginx 模块---------------

## PHP 模块---------------
php_pack_name="${php_pack_folder}.tar.gz";
php_redis_pack_name="${php_redis_pack_folder}.tar.gz";
libmcrypt_pack_name="${libmcrypt_pack_folder}.tar.gz";
mcrypt_pack_name="${mcrypt_pack_folder}.tar.gz";
mhash_pack_name="${mhash_pack_folder}.tar.gz";
## / PHP 模块---------------

## REDIS 模块---------------
redis_pack_name="${redis_pack_folder}.tar.gz";
## / REDIS 模块---------------

if [ 1 = $ins_mysql ]; then
ins_cmake=1;
ins_openssl=1;
fi

if [ 1 = $ins_nginx ]; then
ins_libzip=1;
ins_openssl=1;
ins_pcre=1;
ins_zlib=1;
fi

if [ 1 = $ins_php ]; then
ins_libmcrypt=1;
ins_libzip=1;
ins_mcrypt=1;
ins_mhash=1;
ins_openssl=1;
ins_pcre=1;
ins_zlib=1;
ins_php_redis=1;
fi

if [ 1 = $ins_libzip ]; then
ins_cmake=1;
fi

if [ 1 = $help ]; then
println "${url_software_base}install.sh --url_software_base=${url_software_base} --url_install_base=${url_install_base} --url_config_base=${url_config_base} --url_data_base=${url_data_base} --is_debug=1" blues;
exit;
fi

if [ 0 = $is_debug ]; then
println "    Installation Mode" blues;
else
println "    Debug Mode" blues;
fi

println "Source Path: [$url_software_base]" blues;
println "Program Path: [$url_install_base]" blues;

if [ 0 = $is_debug ]; then
shl_exec "$shl_cmd";
shl_exec "yum -y install automake autoconf";
shl_exec "mkdir -p $url_install_base";
shl_exec "mkdir -p $url_config_base";
shl_exec "mkdir -p $url_data_base";
shl_exec "mkdir -p ${url_data_base}wwwroot";
shl_exec "mkdir -p $url_path_base";
shl_exec "mkdir -p ${url_path_base}tmp ${url_path_base}logs";
shl_exec "chmod 777 ${url_path_base}tmp ${url_path_base}logs";
else
println "$shl_cmd" purple;
println "yum -y install automake autoconf" purple;
println "mkdir -p $url_install_base" purple;
println "mkdir -p $url_config_base" purple;
println "mkdir -p $url_data_base" purple;
println "mkdir -p ${url_data_base}wwwroot" purple;
println "mkdir -p $url_path_base" purple;
println "mkdir -p ${url_path_base}tmp ${url_path_base}logs" purple;
println "chmod 777 ${url_path_base}tmp ${url_path_base}logs" purple;
fi

#安装OPENSSL
if [ 1 = $ins_openssl ]; then
. ${url_software_base}fun/fun_ins_openssl.sh;
fun_ins_openssl;
fi

#安装CMAKE
if [ 1 = $ins_cmake ]; then
. ${url_software_base}fun/fun_ins_cmake.sh;
fun_ins_cmake;
fi

#安装MYSQL
if [ 1 = $ins_mysql ]; then
. ${url_software_base}fun/fun_ins_mysql.sh;
fun_ins_mysql;
fi

#安装PCRE
if [ 1 = $ins_pcre ]; then
. ${url_software_base}fun/fun_ins_pcre.sh;
fun_ins_pcre;
fi
#安装ZLIB
if [ 1 = $ins_zlib ]; then
. ${url_software_base}fun/fun_ins_zlib.sh;
fun_ins_zlib;
fi
#安装LIBZIP
if [ 1 = $ins_libzip ]; then
. ${url_software_base}fun/fun_ins_libzip.sh;
fun_ins_libzip;
fi

#安装NGINX
if [ 1 = $ins_nginx ]; then
. ${url_software_base}fun/fun_ins_nginx.sh;
fun_ins_nginx;
fi

#安装MHASH
if [ 1 = $ins_mhash ]; then
. ${url_software_base}fun/fun_ins_mhash.sh;
fun_ins_mhash;
fi

#安装LIBMCRYPT
if [ 1 = $ins_libmcrypt ]; then
. ${url_software_base}fun/fun_ins_libmcrypt.sh;
fun_ins_libmcrypt;
fi

#安装MCRYPT
if [ 1 = $ins_mcrypt ]; then
. ${url_software_base}fun/fun_ins_mcrypt.sh;
fun_ins_mcrypt;
fi

#安装PHP
if [ 1 = $ins_php ]; then
. ${url_software_base}fun/fun_ins_php.sh;
fun_ins_php;
fi

#安装REDIS
if [ 1 = $ins_redis ]; then
. ${url_software_base}fun/fun_ins_redis.sh;
fun_ins_redis;
fi

#安装PHP_REDIS
if [ 1 = $ins_php_redis ]; then
. ${url_software_base}fun/fun_ins_php_redis.sh;
fun_ins_php_redis;
fi

println "================================================================================" yellow;
