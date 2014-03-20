sudo apt-get update
sudo apt-get install -y nginx
sudo rm -rf /etc/nginx/sites-available/default
sudo cp /vagrant/default /etc/nginx/sites-available/
sudo service nginx restart