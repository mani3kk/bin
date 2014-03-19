#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install sshfs
sudo apt-get update
sudo apt-get install vsftpd
sudo mkdir /srv/ftp
sudo usermod -d /srv/ftp ftp
sudo /etc/init.d/vsftpd restart
sudo rm -rf /etc/vsftpd.conf
sudo cp /vagrant/vsftpd.conf /etc/
sudo /etc/init.d/vsftpd restart
sudo cp /vagrant/test.php /srv/ftp
sudo cp /vagrant/index.php /srv/ftp
sudo cp /vagrant/insert_ac.php /srv/ftp