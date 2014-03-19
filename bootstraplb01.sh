sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get update
sudo apt-get install -y libapache2-mod-php5 php5
sudo /etc/init.d/apache2 restart
sudo a2enmod proxy
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo /etc/init.d/apache2 restart
sudo rm -rf /etc/apache2/conf.d/proxy-balancer
sudo cp /vagrant/proxy-balancer /etc/apache2/conf.d/
sudo rm -rf /etc/apache2/mods-enabled/proxy.conf
sudo cp /vagrant/proxy.conf /etc/apache2/mods-enabled/
sudo /etc/init.d/apache2 restart