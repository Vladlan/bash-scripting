#!/usr/bin/env bash
npm run build --prefix ./../shop-angular-cloudfront/ -- --configuration production
zip -r ./../shop-angular-cloudfront/dist/client-app.zip ./../shop-angular-cloudfront/dist/