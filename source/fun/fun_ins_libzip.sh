##安装LIBZIP
function fun_ins_libzip(){
    println "\n================================================================================" yellow;
    println "-- INSTALL LIBZIP [START]";
    ##是否调试模式
    libzip_is_debug=${is_debug};
    libzip_ins_prefix="/usr/local/libzip";
    if [ 0 = $libzip_is_debug ]; then 
        if [ -f "${libzip_ins_prefix}/bin/zipcmp" ] ; then 
            println "-- LIBZIP IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${libzip_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    libzip_shl=(
        "yum remove libzip-devel libzip"
        "cd ${url_software_base}"
        "tar -zxf ${libzip_pack_name}"
        "cd ${libzip_pack_folder}"
        "mkdir -p build"
        "cd build"
        "cmake -DCMAKE_INSTALL_PREFIX=${libzip_ins_prefix} .."
        "make"
        "make install"
        "if [ -d "${libzip_ins_prefix}/lib64" ] ; then (rm -rf /etc/ld.so.conf.d/libzip-x86_64.conf && echo -e '${libzip_ins_prefix}/lib64/' > /etc/ld.so.conf.d/libzip-x86_64.conf) fi"
        "if [ -d "${libzip_ins_prefix}/lib" ] ; then (rm -rf /etc/ld.so.conf.d/libzip-x86.conf && echo -e '${libzip_ins_prefix}/lib/' > /etc/ld.so.conf.d/libzip-x86.conf) fi"
        "if [ -d "${libzip_ins_prefix}/lib64" ] ; then (rm -rf /usr/lib64/libzip.so && ln -s ${libzip_ins_prefix}/lib64/libzip.so /usr/lib64/libzip.so) fi"
        "if [ -d "${libzip_ins_prefix}/lib" ] ; then (rm -rf /usr/lib/libzip.so && ln -s ${libzip_ins_prefix}/lib/libzip.so /usr/lib/libzip.so) fi"
        "ldconfig -v"
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