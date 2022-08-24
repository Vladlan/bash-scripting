#!/usr/bin/env bash
FE_PATH=./shop-angular-cloudfront/

exitIfLastCommandHadFailed() {
	if [ $? -eq 1 ]
    then
      echo "Command '$1' failed. Please fix it."
      exit 1
  fi
}

npm run lint --prefix "$FE_PATH"
exitIfLastCommandHadFailed "npm run lint"

npm run test --prefix "$FE_PATH" -- --watch=false
exitIfLastCommandHadFailed "npm run test"

npm audit --prefix "$FE_PATH"
exitIfLastCommandHadFailed "npm run test"

