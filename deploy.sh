#!/usr/bin/env bash
FE_DIST_PATH=./fe-angular/dist/
FE_DIST_ZIP_PATH=./fe-angular/dist/be.zip
BE_DIST_ZIP_PATH=./nestjs-rest-api/dist/be.zip
REMOTE_SERVER_IP=192.168.0.3
REMOTE_SERVER_USER=vagrant
PRIVATE_KEY_LOCATION=.vagrant/machines/default/virtualbox/private_key
BE_ENV_FILE=./nestjs-rest-api/.env.prod


checkIfNodeExists() {
	if which node > /dev/null
    then
        echo "NodeJS version:"
		node -v
    else
        echo "NodeJS is not installed"
		exit 1
    fi
}

checkIfNodeExists


checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

stopScriptIfPathDoesNotExist() {
	if test -f "$1"; then
		echo ""
	else
		echo "Path '$1' does not exist!"
		exit 1
	fi
}

stopScriptIfPathDoesNotExist "$BE_ENV_FILE"

echo 'Building FE...'
if [ $(checkIfFileExists "$FE_DIST_ZIP_PATH") -eq 1 ]; then
	rm "$FE_DIST_ZIP_PATH"
fi
npm run build --prefix ./fe-angular/ -- --configuration production

stopScriptIfPathDoesNotExist "$FE_DIST_PATH"

cd FE_DIST_PATH

echo 'Ziping FE...'
zip -r ../fe.zip *
cd ./../../../

echo 'Ziping BE...'
if [ $(checkIfFileExists "$BE_DIST_ZIP_PATH") -eq 0 ]; then
	mkdir ./nestjs-rest-api/dist
fi

zip -r $BE_DIST_ZIP_PATH ./nestjs-rest-api/package.json ./nestjs-rest-api/package-lock.json ./nestjs-rest-api/tsconfig.json ./nestjs-rest-api/tsconfig.build.json ./nestjs-rest-api/.env.prod ./nestjs-rest-api/src/ ./nestjs-rest-api/nest-cli.json  

echo 'Sending files to a server...'
scp -i "$PRIVATE_KEY_LOCATION" ./fe-angular/dist/fe.zip "$REMOTE_SERVER_USER@$REMOTE_SERVER_IP:/../../var/www/"
scp -i "$PRIVATE_KEY_LOCATION" ./nestjs-rest-api/dist/be.zip "$REMOTE_SERVER_USER@$REMOTE_SERVER_IP:/../../var/app/"

echo 'Starting build script on remote server...'
ssh -i "$PRIVATE_KEY_LOCATION"  "$REMOTE_SERVER_USER@$REMOTE_SERVER_IP" 'bash -s' < remote-build.sh
