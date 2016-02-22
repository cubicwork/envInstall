#! /bin/sh
#Server enviroment setup shell script
#by Carney Wu
#based on CentOS7 x86_64 minmum installation.
#set package name
N_automake115=automake-1.15
N_automake17=automake-1.7.9
N_cmake=cmake-3.4.1
N_freetype=freetype-2.6
N_jpeg=jpeg-9a
N_libgd=libgd-2.1.1
N_libmcrypt=libmcrypt-2.5.7
N_libpng=libpng-1.6.20
N_libvpx=libvpx-1.5.0
N_mariadb=mariadb-10.1.10
N_nginx=nginx-1.8.0
N_openssl=openssl-1.0.2e
N_pcre=pcre-8.37
N_php=php-7.0.2
N_sphinx=sphinx-2.2.10-release
N_t1lib=t1lib-5.1.2
N_tiff=tiff-4.0.6
N_yasm=yasm-1.3.0
N_zlib=zlib-1.2.8
#check root privilege
if [ $UID -ne 0 ];then
	echo -e "\033[31m>>>you should be root to execute this script\033[0m"
	exit 1
fi
echo -e "\033[31m>>>This script will reboot this server when all prosedure was done. \033[0m"
read -p "I konw that and start this script [yes|no]: [no]"
if [ x$REPLY == xyes ];then
#yum packages
	echo -e "\033[32m[1/20]:install basic package\033[0m"
	sleep 3
	yum install -y apr* autoconf automake bison bzip2* cloog-ppl compat* cpp curl curl-devel fontconfig fontconfig-devel freetype freetype* freetype-devel gcc gcc-c++ gtk+-devel gd gettext gettext-devel glibc kernel kernel-headers keyutils keyutils-libs-devel krb5-devel libcom_err-devel libpng libpng-devel libjpeg* libsepol-devel libselinux-devel libstdc++-devel libtool* libgomp libxml2 libxml2-devel libXpm* libtiff libtiff* make mpfr ncurses* ntp openssl openssl-devel patch pcre-devel perl php-common php-gd policycoreutils telnet t1lib t1lib* nasm nasm* zlib-devel gd-devel postgresql-libs unixODBC libXaw-devel
	read -p "Press <RETURN> to go on..."
#add useraccounts and groups
	echo -e "\033[32m[2/20]:create account and root for nginx, mariaDB and php-fpm | Create data directory\033[0m"
	sleep 3
	groupadd mysql && useradd -M -g mysql mysql -s /bin/false
	groupadd nginx && useradd -M -g nginx nginx -s /bin/false
	groupadd php && useradd -M -g php php -s /bin/false
	mkdir /data
	mkdir /data/www
	mkdir /data/mysql
	read -p "Press <RETURN> to go on..."
#install tool
#install automake
	echo -e "\033[32m[3/20]:install automake 1.7\033[0m"
	cd $N_automake17
	pwd
	sleep 3
	./configure && make && make install
	read -p "Press <RETURN> to go on..."
	echo -e "\033[32m[4/20]:install automake 1.15\033[0m"
	cd ../$N_automake115
	pwd
	sleep 3
	./configure && make && make install
	read -p "Press <RETURN> to go on..."
#install cmake
	echo -e "\033[32m[5/20]:install cmake\033[0m"
	cd ../$N_cmake
	pwd
	sleep 3
	./configure && make && make install
	read -p "Press <RETURN> to go on..."
#install lib
#install PCRE
	echo -e "\033[32m[6/20]:install PCRE\033[0m"
	cd ../$N_pcre
	pwd
	sleep 3
	./configure --prefix=/usr/local/pcre && make && make install
	read -p "Press <RETURN> to go on..."
#install OpenSSL
	echo -e "\033[32m[7/20]:install OpenSSL\033[0m"
	cd ../$N_openssl
	pwd
	sleep 3
	./config --prefix=/usr/local/openssl && make && make install
	echo 'export PATH=$PATH:/usr/local/openssl/bin'>>/etc/profile
	source /etc/profile
	read -p "Press <RETURN> to go on..."
#install zlib
	echo -e "\033[32m[8/20]:install zlib\033[0m"
	cd ../$N_zlib
	pwd
	sleep 3
	./configure --prefix=/usr/local/zlib && make && make install
	read -p "Press <RETURN> to go on..."
#install yasm
	echo -e "\033[32m[9/20]:install yasm\033[0m"
	cd ../$N_yasm
	pwd
	sleep 3
	./configure && make && make install
	read -p "Press <RETURN> to go on..."
#install libmcrypt
	echo -e "\033[32m[10/20]:install libmcrypt\033[0m"
	cd ../$N_libmcrypt
	pwd
	sleep 3
	./configure && make && make install
	read -p "Press <RETURN> to go on..."
#install libvpx
	echo -e "\033[32m[11/20]:install libvpx\033[0m"
	cd ../$N_libvpx
	pwd
	sleep 3
	./configure --prefix=/usr/local/libvpx --enable-shared --enable-vp9 && make && make install
	read -p "Press <RETURN> to go on..."
#install tiff
	echo -e "\033[32m[12/20]:install tiff\033[0m"
	cd ../$N_tiff
	pwd
	sleep 3
	./configure --prefix=/usr/local/tiff --enable-shared && make && make install
	read -p "Press <RETURN> to go on..."
#install libpng
	echo -e "\033[32m[13/20]:install libpng\033[0m"
	cd ../$N_libpng
	pwd
	sleep 3
	./configure --prefix=/usr/local/libpng --enable-shared --with-x=no && make && make install
	read -p "Press <RETURN> to go on..."
#install freetype
	echo -e "\033[32m[14/20]:install freetype\033[0m"
	cd ../$N_freetype
	pwd
	sleep 3
	./configure --prefix=/usr/local/freetype --enable-shared --with-x=no && make && make install
	read -p "Press <RETURN> to go on..."
#install jpeg
	echo -e "\033[32m[15/20]:install jpeg\033[0m"
	cd ../$N_jpeg
	pwd
	sleep 3
	./configure --prefix=/usr/local/jpeg --enable-shared && make && make install
	read -p "Press <RETURN> to go on..."
#install libgd
	echo -e "\033[32m[16/20]:install libgd\033[0m"
	cd ../$N_libgd
	echo -e "\033[31mModifying src/webpimg.c\033[0m"
	cp -f ../misc/webpimg.c-patch src/webpimg.c
	pwd
	sleep 3
	./configure --prefix=/usr/local/libgd --enable-shared --with-jpeg=/usr/local/jpeg --with-png=/usr/local/libpng --with-freetype=/usr/local/freetype --with-fontconfig=/usr/local/freetype --with-xpm=/usr/ --with-tiff=/usr/local/tiff --with-vpx=/usr/local/libvpx && make && make install
	read -p "Press <RETURN> to go on..."
#install t1lib
	echo -e "\033[32m[17/20]:install t1lib\033[0m"
	cd ../$N_t1lib
	pwd
	sleep 3
	./configure --prefix=/usr/local/t1lib --enable-shared && make without_doc && make install
	read -p "Press <RETURN> to go on..."
#install main soft
#install nginx
	echo -e "\033[32m[18/20]:install nginx\033[0m"
	cd ../$N_nginx
	pwd
	sleep 3
	./configure --prefix=/usr/local/nginx \
	--without-http_memcached_module \
	--user=nginx \
	--group=nginx \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	--with-http_gzip_static_module \
	--with-http_stub_status_module \
	--with-http_sub_module \
	--with-http_gzip_static_module
	make && make install
	echo -e "\033[31mModifying /usr/local/nginx/conf/nginx.conf\033[0m"
	cp -f ../misc/nginx.conf-patch /usr/local/nginx/conf/nginx.conf
	echo -e "\033[31mSetup init.d script\033[0m"
	cp -f ../misc/nginx.init /etc/rc.d/init.d/nginx
	echo -e "\033[31mSetup test html page\033[0m"
	cp -f ../misc/test.html /data/www/index.htm
	echo -e "\033[31mAdd sbin to system path\033[0m"
	echo 'export PATH=$PATH:/usr/local/nginx/sbin'>>/etc/profile && source /etc/profile
	echo -e "\033[31mStart nginx\033[0m"
	chmod 775 /etc/rc.d/init.d/nginx && chkconfig nginx on && /etc/rc.d/init.d/nginx start
	read -p "Press <RETURN> to go on..."
#install mariadb
	echo -e "\033[32m[19/20]:install MariaDB\033[0m"
	cd ../$N_mariadb
	pwd
	sleep 3
	cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/mysqldata/ -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
  make && make install
  echo -e "\033[31mSetup init.d script\033[0m"
  chown -R mysql:mysql /usr/local/mysql
	cp /usr/local/mysql/support-files/mysql.server /etc/rc.d/init.d/mysqld && chmod 755 /etc/init.d/mysqld && chkconfig --add mysqld && chkconfig mysqld on
	echo -e "\033[31mInitailize MariaDB\033[0m"
	/usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql
	echo -e "\033[31mSet configfile\033[0m"
	cp -f ../misc/my.cnf-patch /etc/my.cnf
	echo -e "\033[31mAdd bin to system path\033[0m"
	echo 'export PATH=/usr/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
  mkdir /var/log/mariadb/
  chown -R mysql:mysql /var/log/mariadb/
  echo -e "\033[32mStart MariaDB\033[0m"
	service mysqld start
	echo -e "\033[31mSet links for PHP\033[0m"
	ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql && ln -s /usr/local/mysql/include/mysql /usr/include/mysql && mkdir /var/lib/mysql && ln -s /tmp/mysql.sock /var/lib/mysql/mysql.sock
  echo -e "\033[32m>>>Set MariaDB\033[0m"
	/usr/local/mysql/bin/mysql_secure_installation
  read -p "Press <RETURN> to go on..."
#install php
	echo -e "\033[32m[20/20]:install PHP\033[0m"
	cd ../$N_php
	pwd
	sleep 3
	echo -e "\033[32mPre-config for x86_64 system\033[0m"
	ln -s /usr/lib64/libltdl.so /usr/lib/libltdl.so
	cp -frp /usr/lib64/libXpm.so* /usr/lib/
	echo -e "\033[32mExport LD_LABRARY_PATH\033[0m"
	export LD_LIBRARY_PATH=/usr/local/libgd/lib:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=/usr/local/libpng/lib:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=/usr/local/jpeg/lib:$LD_LIBRARY_PATH
	echo -e "\033[32mInstall PHP\033[0m"
	./configure \
	--prefix=/usr/local/php \
	--with-config-file-path=/usr/local/php/etc \
	--enable-fpm \
	--with-fpm-user=nginx \
	--with-fpm-group=nginx \
	--enable-bcmath \
	--enable-calendar \
	--with-curl \
	--enable-dba \
	--enable-exif \
	--enable-ftp \
	--with-gd \
	--with-jpeg-dir=/usr/local/jpeg \
	--with-png-dir=/usr/local/libpng \
	--with-zlib-dir=/usr/local/zlib \
	--with-xpm-dir=/usr/ \
	--with-freetype-dir=/usr/local/freetype \
	--with-openssl \
	--enable-gd-native-ttf \
	--enable-gd-jis-conv \
	--with-gettext \
	--with-mhash \
	--with-openssl-dir=/usr/local/openssl \
	--enable-mbstring \
	--with-mysqli=/usr/local/mysql/bin/mysql_config \
	--with-mysql-sock=/tmp/mysql.sock \
	--enable-pcntl \
	--with-pdo-mysql=/usr/local/mysql \
	--enable-shmop \
	--enable-soap \
	--with-xmlrpc \
	--enable-sockets \
	--enable-sysvmsg \
	--enable-sysvsem \
	--enable-sysvshm \
	--enable-zip \
	--enable-mysqlnd \
	--with-pear
	make && make install
	echo -e "\033[31mAdd bin to system path\033[0m"
	echo 'export PATH=$PATH:/usr/local/php/bin' >> /etc/profile && source /etc/profile
	echo 'export PATH=$PATH:/usr/local/php/sbin' >> /etc/profile && source /etc/profile
	echo -e "\033[32m>>>Set php.ini type\033[0m"
	read -p "Set php.ini to development settings ?[yes|no]: [no]"
	if [ x$REPLY == xyes ];then
		cp -f ../misc/php.ini-dev /usr/local/php/etc/php.ini
	else
		cp -f ../misc/php.ini-prod /usr/local/php/etc/php.ini
	fi
	cp -f ../misc/php-fpm.conf-patch /usr/local/php/etc/php-fpm.conf
	cp -f ../misc/www.conf-patch /usr/local/php/etc/php-fpm.d/www.conf
	echo -e "\033[31m>>>Setup init.d script\033[0m"
	cp -f ../misc/php-fpm.init /etc/rc.d/init.d/php-fpm
	chmod +x /etc/rc.d/init.d/php-fpm
	mkdir /var/log/php-fpm/
	chown nginx:nginx /var/log/php-fpm/
	chkconfig php-fpm on
	echo -e "\033[31m>>>Start php-fpm\033[0m"
	service php-fpm start
	service nginx restart
	echo -e "\033[31mSetup test html page\033[0m"
	cp -f ../misc/info.php /data/www/info.php
  chown -R nginx:nginx /data/www
#installation finished
	echo -e "\033[32minstallation finished!\033[0m"
	read -p "Press <RETURN> to reboot this server..."
	reboot
	exit 0
else
	echo bye.
	exit 1
fi
