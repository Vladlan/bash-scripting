#!/usr/bin/env bash

PIPLINE_FILE_PATH="./pipline.json"
# NOW=$(date +"%d_%m_%Y_%H_%M_%S")
NOW="2"
BRANCH=$(git symbolic-ref -q HEAD)
BRANCH=${BRANCH##refs/heads/}
OWNER=$(git config --global --get user.email)
POLL_FOR_SOURCE_CHANGES=false
CONFIGURATION='production'

checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

if [ $(checkIfFileExists "$PIPLINE_FILE_PATH") == 0 ]; then
	echo "File '$PIPLINE_FILE_PATH' does not exists"
    exit 1
fi

echo $(cat "./pipline.json" | jq 'del(.metadata)') > "./pipline-$NOW.json"
echo $(jq ".pipeline.version = .pipeline.version+1" "./pipline-$NOW.json") > "./pipline-$NOW.json"
echo $(jq --arg BRANCH "$BRANCH" '.pipeline.stages[0].actions[0].configuration.Branch = $BRANCH' "./pipline-$NOW.json") > "./pipline-$NOW.json"
echo $(jq --arg OWNER "$OWNER" '.pipeline.stages[0].actions[0].configuration.Owner = $OWNER' "./pipline-$NOW.json") > "./pipline-$NOW.json"
echo $(jq ".pipeline.stages[0].actions[0].configuration.PollForSourceChanges = $POLL_FOR_SOURCE_CHANGES" "./pipline-$NOW.json") > "./pipline-$NOW.json"
echo $(jq --arg CONFIGURATION "$CONFIGURATION" '((.. | .EnvironmentVariables?) |= if . == null then empty else gsub("{{BUILD_CONFIGURATION value}}"; $CONFIGURATION) end )' "./pipline-$NOW.json") > "./pipline-$NOW.json"
