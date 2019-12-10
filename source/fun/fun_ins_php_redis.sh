##安装PHP_REDIS
function fun_ins_php_redis(){
    println "\n================================================================================" yellow;
    println "-- INSTALL PHP_REDIS [START]";
    ##是否调试模式
    php_redis_is_debug=${is_debug};
    php_ins_bin="${url_install_base}php/${php_version}/bin";
    ##依次命令
    php_redis_shl=(
        "cd ${url_software_base}"
        "tar zxf ${php_redis_pack_name}"
        "cd ${php_redis_pack_folder}"
        "${php_ins_bin}/phpize"
        "./configure --with-php-config=${php_ins_bin}/php-config --with-zlib-dir"
        "make"
        "make install"
    );
    php_redis_shl_len=${#php_redis_shl[*]};
    i=0;
    while [ $i -lt $php_redis_shl_len ]; do
        println "${php_redis_shl[$i]}" purple;
        if [ 0 = $php_redis_is_debug ]; then 
            shl_exec "${php_redis_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${php_redis_shl[$i]}""]" green;
            else
                println "ERROR [""${php_redis_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL PHP_REDIS FINISH (Please modify file php.ini)";
    println "================================================================================\n" yellow;
}