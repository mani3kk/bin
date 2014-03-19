#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get update
sudo apt-get install -y libapache2-mod-php5 php5
sudo /etc/init.d/apache2 restart
sudo rm /var/www/index.html
sudo apt-get update
sudo apt-get install curlftpfs
sudo curlftpfs -o allow_other anonymous:anonymous@192.168.10.6 /var/www
echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections
sudo apt-get install -y mysql-server
DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin
sudo ln -sv /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf
sudo /etc/init.d/apache2 restart
cd /vagrant
mysql --user=root --password=vagrant test < test.sql
sudo rm -rf /etc/mysql/my.cnf
sudo cp /vagrant/my.cnf /etc/mysql/
echo "CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypass';" | mysql --user=root --password=vagrant
echo "GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypass' WITH GRANT OPTION;" | mysql --user=root --password=vagrant
sudo /etc/init.d/mysql restart