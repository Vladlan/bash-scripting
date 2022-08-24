#!/usr/bin/env bash
FE_DIST_ZIP_PATH=./../shop-angular-cloudfront/dist/client-app.zip

checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

if [ $(checkIfFileExists "$FE_DIST_ZIP_PATH") -eq 1 ]; then
    echo "$FE_DIST_ZIP_PATH"
	rm "$FE_DIST_ZIP_PATH"
fi

npm run build --prefix ./../shop-angular-cloudfront/ -- --configuration production
zip -r ./../shop-angular-cloudfront/dist/client-app.zip ./../shop-angular-cloudfront/dist/