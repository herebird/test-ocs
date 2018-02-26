mkdir -p /home/vps/public_html

useradd -m vps

mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html


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
