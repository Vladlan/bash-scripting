#!/usr/bin/env bash
FE_PATH=./fe-angular/
BE_PATH=./nestjs-rest-api/

echo 'Preparing FE...'
npm i --force --prefix "$FE_PATH"

echo 'Preparing BE...'
npm i --force --prefix "$BE_PATH"