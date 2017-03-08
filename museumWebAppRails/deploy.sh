echo "****** cd to /var/www/museum_monitoring_sensors"
cd /var/www/museum_monitoring_sensors
echo "****** Removing any non saved changes"
sudo git checkout .
echo "****** Pulling the latest code"
sudo git pull
echo "****** cd into app"
cd museumWebAppRails
echo "****** bundle install"
sudo bundle install --deployment --without development test
echo "****** assets compile"
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
echo ""
echo "****** Getting secret key"
sudo bundle exec rake secret
echo "****** Please place the secret key in config/secrets.yml in place of <%= ENV[SECRET_KEY_BASE] %>"
echo "****** Once you have done this run: sudo passenger-config restart-app $(pwd)"