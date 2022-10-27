Prerequisites:

1. Install vagrant
2. Ran `vagrant up` to up virtual ubuntu server on your local machine
3. Ran `vagrant ssh` to connect to virtual ubuntu server over ssh
4. You will have to install nodejs, zip, unzip on your ubuntu server
5. Ran `sudo ./deploy.sh` to deploy be and fe to your virtual ubuntu server
6. If everything is fine than you will be able to access API on vagrant virtual server ip on port written in ./nestjs-rest-api/.env.prod
7. In the end run `vagrant halt`