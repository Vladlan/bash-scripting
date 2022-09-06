#!/usr/bin/env bash
echo 'Unzipping FE...'
cd /var/www/
unzip -o ./fe.zip -d ./eshop.local

echo 'Unzipping BE...'
cd /var/app/
unzip -o ./be.zip

# Even in the lab2 task requirement is to send dist folder 
# It is better to build BE on a final server since node_modules can contain binary files which OS specific 
# And for nestjs default build config it will be needed to install node_modules on a server
echo 'Building BE...'
cd ./nestjs-rest-api
npm ci
npm run build
./node_modules/pm2/bin/pm2 stop nestjs-api
./node_modules/pm2/bin/pm2 delete nestjs-api
npm run start:pm2 -- --watch