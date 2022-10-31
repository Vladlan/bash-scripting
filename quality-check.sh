#!/usr/bin/env bash
echo "Checking quality of a Frontent..."
cd ./fe-angular
npm run lint
npm audit
npm run test:coverage


echo "Checking quality of a Backend..."
cd ./../nestjs-rest-api
npm run lint
npm audit
npm run test:cov
