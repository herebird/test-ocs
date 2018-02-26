#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
			   
               echo "Connect ocspanel.info..."
               sleep 1
               
			   echo "กำลังตรวจสอบ Permision..."
               sleep 1
               
			   echo -e "${green}ได้รับอนุญาตแล้ว...${NC}"
               sleep 1
			   
flag=0

if [ $USER != 'root' ]; then
	echo "คุณต้องเรียกใช้งานนี้เป็น root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;

if [[ -e /etc/debian_version ]]; then
	#OS=debian
	RCLOCAL='/etc/rc.local'
else
	echo "คุณไม่ได้เรียกใช้สคริปต์นี้ในระบบปฏิบัติการ Debian"
	exit
fi

vps="VPS";

if [[ $vps = "VPS" ]]; then
	source="http://ocspanel.info"
else
	source="http://เฮียเบิร์ด.com"
fi

# GO TO ROOT
cd

MYIP=$(wget -qO- ipv4.icanhazip.com);

flag=0	

clear
echo "------------------ ระบบแอป ออโต้อัพเดต ออโต้เซ็ทอัพ ----------------"

echo "            DEVELOPED BY OCSPANEL.INFO / ( 097-026-7262 )         "
echo ""
echo ""
echo "ยินดีต้อนรับสู่ Osc Panel Auto Script : กรุณายืนยันการตั้งค่าต่าง ๆ ดังนี้"
echo "คุณสามารถใช้ข้อมูลของตัวเองได้เพียงแค่ กดลบ หรือ กด Enter ถ้าคุณเห็นด้วยกับข้อมูลของเรา"
echo ""
echo "1.ตั้งรหัสผ่านใหม่สำหรับ user root MySQL:"
read -p "Password baru: " -e -i abc12345 DatabasePass
echo ""
echo "2.ตั้งค่าชื่อฐานข้อมูลสำหรับ OCS Panels"
echo "โปรดใช้ตัวอัพษรปกติเท่านั้นห้ามมีอักขระพิเศษอื่นๆที่ไม่ใช่ขีดล่าง (_)"
read -p "Nama Database: " -e -i OCS_PANEL DatabaseName
echo ""
echo "เอาล่ะ [ พี่เทพ ] นี่คือทั้งหมดที่ระบบ Ocs Script ต้องการ เราพร้อมที่จะติดตั้ง Auto Updete ของคุณแล้ว"
read -n1 -r -p "กดปุ่ม Enter เพื่อดำเนินการต่อ ..."

apt-get update && apt-get upgrade -y

apt-get install curl -y

apt-get install apache2 -y

apt-get install php5 libapache2-mod-php5 php5-mcrypt -y

service apache2 restart

sleep 10

apt-get install mysql-server

mysql_install_db

mysql_secure_installation

apt-get install phpmyadmin -y

php5enmod mcrypt

service apache2 restart

sleep 10


ln -s /usr/share/phpmyadmin /home/vps/public_html/


apt-get install libssh2-1-dev libssh2-php -y


php -m |grep ssh2

apt-get install php5-curl


service apache2 restart

sleep 10

mkdir -p /home/vps/public_html

useradd -m vps

mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html

service php5-fpm restart

sleep 10

apt-get -y install zip unzip

cd /home/vps/public_html

#wget https://github.com/rasta-team/Full-OCS/raw/master/panelocs.zip
wget http://เฮียเบิร์ด.com/ocspanel/Config/at-update.zip

mv at-update.zip LTEOCS.zip

unzip LTEOCS.zip

rm -f LTEOCS.zip

rm -f index.html

chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html

#mysql -u root -p
so2=$(expect -c "
spawn mysql -u root -p; sleep 3
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"CREATE DATABASE IF NOT EXISTS $DatabaseName;EXIT;\r\"
expect eof; ")
echo "$so2"
#pass
#CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;

chmod 777 /home/vps/public_html/index.php

clear
echo ""
echo "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo ""
echo "รายละเอียดที่ควรจำ โปรดจดบันทึกไว้"
echo "Database:"
echo "- Database Host: localhost"
echo "- Database Name: $DatabaseName"
echo "- Database User: root"
echo "- Database Pass: $DatabasePass"
echo ""
echo "หากคุณแน่ใจว่า จดจำได้แล้ว กด [ENTER]!"

sleep 3
echo ""
read -p "หากขั้นตอนข้างต้นเสร็จสิ้นโปรดกดปุ่ม [Enter] เพื่อดำเนินการต่อ ..."
echo ""
read -p "หาก [ พี่เทพ ] มั่นใขว่าขั้นตอนข้างต้นได้ทำเสร็จแล้วโปรดกดปุ่ม [Enter] เพื่อดำเนินการต่อ ..."
echo ""

cd /root

apt-get update

service webmin restart

apt-get -y --force-yes -f install libxml-parser-perl

echo "unset HISTFILE" >> /etc/profile

chmod 755 /home/vps/public_html/config
chmod 644 /home/vps/public_html/config/inc.php
chmod 644 /home/vps/public_html/config/route.php

# info
clear
echo "=======================================================" | tee -a log-install.txt
echo "กรุณาเข้าสู่ระบบ OCS Panel ที่ http://$MYIP:81/" | tee -a log-install.txt

echo "" | tee -a log-install.txt
#echo "บันทึกการติดตั้ง --> /root/log-install.txt" | tee -a log-install.txt
#echo "" | tee -a log-install.txt
echo "โปรดรีบูต VPS ของคุณ!" | tee -a log-install.txt
echo "=======================================================" | tee -a log-install.txt
rm -f /root/at-update.sh
cd ~/
