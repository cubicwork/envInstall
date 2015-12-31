#! /bin/sh
#Server enviroment setup shell script
#by Carney Wu
#based on CentOS7 x86_64 minmum installation.
#preInstallation shell script
N_automake115=automake-1.15.tar.gz
N_automake17=automake-1.7.9.tar.bz2
N_cmake=cmake-3.4.1.tar.gz
N_freetype=freetype-2.6.tar.gz
N_jpeg=jpegsrc.v9a.tar.gz
N_libgd=libgd-2.1.1.tar.gz
N_libmcrypt=libmcrypt-2.5.7.tar.gz
N_libpng=libpng-1.6.20.tar.gz
N_libvpx=libvpx-1.5.0.tar.bz2
N_mariadb=mariadb-10.1.10.tar.gz
N_nginx=nginx-1.8.0.tar.gz
N_openssl=openssl-1.0.2e.tar.gz
N_pcre=pcre-8.37.tar.gz
N_php=php-7.0.1.tar.gz
N_sphinx=sphinx-2.2.10-release.tar.gz
N_t1lib=t1lib-5.1.2.tar.gz
N_tiff=tiff-4.0.6.tar.gz
N_yasm=yasm-1.3.0.tar.gz
N_zlib=zlib-1.2.8.tar.gz
if [ $UID -ne 0 ];then
	echo -e "\033[31m>>>you should be root to execute this script\033[0m"
	exit 1
fi
echo -e "\033[31m>>>This script will reboot this server when all prosedure was done. \033[0m"
read -p "I konw that and start this script [yes|no]: [no]"
if [ x$REPLY == xyes ];then
	echo -e "\033[32m[1/4]:update system\033[0m"
	sleep 3
	yum makecache && yum -y update
	echo -e "\033[32m[2/4]:install basic tools\033[0m"
	sleep 3
	yum -y install bash-completion vim net-tools bind-utils wget screen bzip2
	echo -e "\033[32m[3/4]:unzip archive files\033[0m"
  chmod -R 0771 ./*
	tar -xf $N_automake115
	tar -xf $N_automake17
	tar -xf $N_cmake
	tar -xf $N_freetype
	tar -xf $N_jpeg
	tar -xf $N_libgd
	tar -xf $N_libmcrypt
	tar -xf $N_libpng
	tar -xf $N_libvpx
	tar -xf $N_mariadb
	tar -xf $N_nginx
	tar -xf $N_openssl
	tar -xf $N_pcre
	tar -xf $N_php
	tar -xf $N_sphinx
	tar -xf $N_t1lib
	tar -xf $N_tiff
	tar -xf $N_yasm
	tar -xf $N_zlib
	echo -e "\033[32m[4/4]:reboot server\033[0m"
	sleep 3
	reboot
	exit 0
else
	echo bye.
	exit 1
fi
