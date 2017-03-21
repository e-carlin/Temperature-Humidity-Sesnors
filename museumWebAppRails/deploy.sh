#!/bin/bash
echo "****** cd to /var/www/museum_monitoring_sensors"
cd /var/www/museum_monitoring_sensors
echo "****** Removing any non saved changes"
git checkout .
echo "****** Pulling the latest code"
git pull
echo "****** cd into app"
cd museumWebAppRails
echo "****** bundle install"
bundle install --deployment --without development test
echo "****** assets compile"
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
echo ""
echo "****** Getting secret key"
secretKey=$(bundle exec rake secret)
echo $secretKey
echo "******* Replacing scret key"
sed -ie "s/keyToBeReplaced/$secretKey/g" config/secrets.yml
echo "******** Deleting temp file (if it asks you if you wish to delete file say yes)"
rm config/secrets.ymle
echo "******** Restarting the app"
sudo passenger-config restart-app $(pwd)
