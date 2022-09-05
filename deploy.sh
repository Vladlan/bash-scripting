#!/usr/bin/env bash
FE_DIST_ZIP_PATH=./fe-angular/dist/be.zip
BE_DIST_ZIP_PATH=./nestjs-rest-api/dist/be.zip

checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

echo 'Building FE...'
if [ $(checkIfFileExists "$FE_DIST_ZIP_PATH") -eq 1 ]; then
	rm "$FE_DIST_ZIP_PATH"
fi
npm run build --prefix ./fe-angular/ -- --configuration production
cd ./fe-angular/dist/app/
zip -r ../fe.zip *
cd ./../../../

echo 'Building BE...'
if [ $(checkIfFileExists "$BE_DIST_ZIP_PATH") -eq 1 ]; then
	rm "$BE_DIST_ZIP_PATH"
fi
npm run build --prefix ./nestjs-rest-api/
zip -r ./nestjs-rest-api/dist/be.zip ./nestjs-rest-api/package.json ./nestjs-rest-api/package-lock.json ./nestjs-rest-api/tsconfig.json ./nestjs-rest-api/tsconfig.build.json ./nestjs-rest-api/.env ./nestjs-rest-api/src/ ./nestjs-rest-api/nest-cli.json  

echo 'Sending files to a server...'
scp -i .vagrant/machines/default/virtualbox/private_key ./fe-angular/dist/fe.zip vagrant@192.168.0.3:/../../var/www/
scp -i .vagrant/machines/default/virtualbox/private_key ./nestjs-rest-api/dist/be.zip vagrant@192.168.0.3:/../../var/app/

echo 'Starting build script on remote server...'
ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@192.168.0.3 'bash -s' < remote-build.sh
