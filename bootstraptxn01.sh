#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y build-essential apache2 php5-gd wget libgd2-xpm libgd2-xpm-dev libapache2-mod-php5 sendmail daemon
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.2.tar.gz
sudo tar -xvzf nagios-4.0.2.tar.gz
cd nagios-4.0.2/
sudo ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-mail=/usr/bin/sendmail
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
sudo make install-webconf
sudo cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
sudo chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers
sudo sed -i "s/^\.\ \/etc\/rc.d\/init.d\/functions$/\.\ \/lib\/lsb\/init-functions/g" /etc/init.d/nagios
sudo sed -i "s/status\ /status_of_proc\ /g" /etc/init.d/nagios
sudo sed -i "s/daemon\ --user=\$user\ \$exec\ -ud\ \$config/daemon\ --user=\$user\ --\ \$exec\ -d\ \$config/g" /etc/init.d/nagios
sudo sed -i "s/\/var\/lock\/subsys\/\$prog/\/var\/lock\/\$prog/g" /etc/init.d/nagios
sudo sed -i "s/\/sbin\/service\ nagios\ configtest/\/usr\/sbin\/service\ nagios\ configtest/g" /etc/init.d/nagios
sudo sed -i "s/\"\ \=\=\ \"/\"\ \=\ \"/g" /etc/init.d/nagios
sudo sed -i "s/\#\#killproc\ \-p\ \${pidfile\}\ \-d\ 10/killproc\ \-p \${pidfile\}/g" /etc/init.d/nagios
sudo sed -i "s/runuser/su/g" /etc/init.d/nagios
sudo sed -i "s/use_precached_objects=\"false\"/&\ndaemonpid=\$(pidof daemon)/" /etc/init.d/nagios
sudo sed -i "s/killproc\ -p\ \${pidfile}\ -d\ 10\ \$exec/\/sbin\/start-stop-daemon\ --user=\$user\ \$exec\ --stop/g" /etc/init.d/nagios
sudo sed -i "s/\/sbin\/start-stop-daemon\ --user=\$user\ \$exec\ --stop/&\n\tkill -9 \$daemonpid/" /etc/init.d/nagios
sudo service nagios start
sudo service nagios
sudo wget http://www.nagios-plugins.org/download/nagios-plugins-1.5.tar.gz
sudo tar -xvzf nagios-plugins-1.5.tar.gz
cd nagios-plugins-1.5/
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install
sudo cp /etc/apache2/conf.d/nagios.conf /etc/apache2/sites-available/nagios
sudo ln -s /etc/apache2/sites-available/nagios /etc/apache2/sites-enabled/nagios
sudo service nagios stop
sudo chown -R nagios:www-data /usr/local/nagios/var/rw/
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo ln -s /etc/init.d/nagios /etc/rcS.d/S98nagios
sudo ln -s /etc/init.d/apache2 /etc/rcS.d/S99apache2
sudo rm -rf /usr/local/nagios/etc/nagios.cfg
sudo cp /vagrant/nagios.cfg /usr/local/nagios/etc/
sudo cp /vagrant/hosts.cfg /usr/local/nagios/etc/
sudo cp /vagrant/hostgroups.cfg /usr/local/nagios/etc/objects/
sudo rm -rf /usr/local/nagios/etc/htpasswd.users
sudo cp /vagrant/htpasswd.users /usr/local/nagios/etc/
sudo service nagios start
sudo service apache2 restart