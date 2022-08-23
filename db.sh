#!/usr/bin/env bash

DB_FILE_PATH=./data/users.db

add() {
	read -p "Type username " username
	read -p "Type role " role
	mkdir -p data
	echo "$username,$role" >> "$DB_FILE_PATH"
}

backup() {
	now=$(date +"%d_%m_%Y_%H_%M_%S")
	mkdir -p backups
	cp "$DB_FILE_PATH" "./backups/$now-users.db.backup"
}

restore () {
	if test -f "$DB_FILE_PATH"; then
    	lastBackup=$(ls -rtc ./backups | tail -1)
		content=$(cat "./backups/$lastBackup")
		echo "$content" > "$DB_FILE_PATH"
	else
		echo "No backup file found"
	fi	
}

case $1 in
	"add") add;;
	"backup") backup;;
	"restore") restore;;
	"help") echo "Available commands are: add, backup, find, list, help";;
	*) echo "'$1' is not supported script command. Run it with help argument to see which arguments are available"
esac