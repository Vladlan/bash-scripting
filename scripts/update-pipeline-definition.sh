#!/usr/bin/env bash

if ! command -v jq &> /dev/null
then
    echo "'jq' could not be found. Please install it."
    exit 1
fi

PIPLINE_FILE_PATH=""
NOW=$(date +"%d_%m_%Y_%H_%M_%S")
BRANCH=$(git symbolic-ref -q HEAD)
BRANCH=${BRANCH##refs/heads/}
OWNER=$(git config --global --get user.email)
POLL_FOR_SOURCE_CHANGES=false
CONFIGURATION='production'

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -c|--configuration)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        CONFIGURATION=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -o|--owner)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        OWNER=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -b|--branch)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        BRANCH=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -p|--poll-for-source-changes)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        POLL_FOR_SOURCE_CHANGES=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *)
      PIPLINE_FILE_PATH="$1"
      shift
      ;;
  esac
done

checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

if [ $(checkIfFileExists "$PIPLINE_FILE_PATH") == 0 ]; then
	echo "Pipline file on path '$PIPLINE_FILE_PATH' does not exists"
    exit 1
fi

echo $(cat "$PIPLINE_FILE_PATH" | jq 'del(.metadata)') > "./pipeline-$NOW.json"
echo $(jq ".pipeline.version = .pipeline.version+1" "./pipeline-$NOW.json") > "./pipeline-$NOW.json"
echo $(jq --arg BRANCH "$BRANCH" '.pipeline.stages[0].actions[0].configuration.Branch = $BRANCH' "./pipeline-$NOW.json") > "./pipeline-$NOW.json"
echo $(jq --arg OWNER "$OWNER" '.pipeline.stages[0].actions[0].configuration.Owner = $OWNER' "./pipeline-$NOW.json") > "./pipeline-$NOW.json"
echo $(jq ".pipeline.stages[0].actions[0].configuration.PollForSourceChanges = $POLL_FOR_SOURCE_CHANGES" "./pipeline-$NOW.json") > "./pipeline-$NOW.json"
echo $(jq --arg CONFIGURATION "$CONFIGURATION" '((.. | .EnvironmentVariables?) |= if . == null then empty else gsub("{{BUILD_CONFIGURATION value}}"; $CONFIGURATION) end )' "./pipeline-$NOW.json") > "./pipeline-$NOW.json"
