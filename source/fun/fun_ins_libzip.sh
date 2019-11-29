##安装LIBZIP
function fun_ins_libzip(){
    println "\n================================================================================" yellow;
    println "-- INSTALL LIBZIP [START]";
    ##是否调试模式
    libzip_is_debug=${is_debug};
    libzip_ins_prefix="${url_install_base}libzip";
    if [ 0 = $libzip_is_debug ]; then 
        if [ -d "${libzip_ins_prefix}" ] ; then 
            println "-- LIBZIP IS INSTALL" red;
            println "-- REINSTALL PLEASE DELETE [rm -rf ${libzip_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    libzip_shl=(
        "cd ${url_software_base}"
        "tar zxf ${libzip_pack_name}"
        "cd ${libzip_pack_folder}"
        "mkdir -p build"
        "cd build"
        "cmake -DCMAKE_INSTALL_PREFIX=${libzip_ins_prefix} .."
        "make"
        "make install"
    );
    libzip_shl_len=${#libzip_shl[*]};
    i=0;
    while [ $i -lt $libzip_shl_len ]; do
        println "${libzip_shl[$i]}" purple;
        if [ 0 = $libzip_is_debug ]; then 
            shl_exec "${libzip_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${libzip_shl[$i]}""]" green;
            else
                println "ERROR [""${libzip_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL LIBZIP FINISH";
    println "================================================================================\n" yellow;
}