# envInstall
A web environment pack and installation script based on RHEL / CentOS minimum installation.
# Content
	1 Introduction
	2 System requirement
	3 How to use
	4 Tips
# Introduction
EnvInstall was used for building server environment. After you have a minimum installation of RHEL7 based Linux operate system you can use this pack to build server enviroment quickly.
# System requirement
	1. A operate system with upstream source from RHEL 7. e.g. RHEL 7, CentOS 7, Scientific Linux 7 etc.
	2. Minimum installation at least.
# How to use
	1. Download envInstall to your server.
		$ mkdir ~/env
		$ cd ~/env
		$ yum install -y wget unzip
		$ wget https://github.com/cubicwork/envInstall/archive/master.zip
	2. Unzip archive
		$ unzip envInstall-master.zip
	3. Execute preinstall.sh
		$ cd envInstall-master
		# chmod +x preinstall.sh
		# ./preinstall.sh
	4.	Excute install.sh
		# cd ~/env/envInstall-master
		#./install.sh
# Tips
	1. Both preinstall.sh and install.sh should be execute by root.
	2. Server will reboot after shell script executed.
	3. The library pack in zip archive can be download and replaced.
		
		
