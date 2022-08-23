#!/usr/bin/env bash

DB_FILE_PATH=./data/users.db

add() {
	read -rep $'Type username:\n' username
	read -rep $'Type role:\n' role
	checkIfShouldCreateFileOrExit "$DB_FILE_PATH"
    echo "$username,$role" >> "$DB_FILE_PATH"
}

backup() {
	checkIfShouldCreateFileOrExit "$DB_FILE_PATH"
	now=$(date +"%d_%m_%Y_%H_%M_%S")
	mkdir -p backups
	cp "$DB_FILE_PATH" "./backups/$now-users.db.backup"
}

touch2() { 
	mkdir -p "$(dirname "$1")" && touch "$1" ; 
}

checkIfShouldCreateFileOrExit() {
	[ -z "$1" ] && echo "You have to specify file path arg for checkIfShouldCreateFileOrExit" && exit 1
	if [ $(checkIfFileExists "$1") == 0 ]; then
		read -rep "File '$1' does not exists. Type 'y' to create a file and continue... " shoudCreate
		if [ "$shoudCreate" = "y" ]; then
			touch2 "$1"
		else 
			exit 1
		fi
	fi

}

checkIfFileExists() {
	if test -f "$1"; then
		echo 1
	else
		echo 0
	fi
}

restore() {
	checkIfShouldCreateFileOrExit "$DB_FILE_PATH"
    lastBackup=$(ls -rtc ./backups | tail -1)
	backupFilePath="./backups/$lastBackup"
	if [ $(checkIfFileExists "$backupFilePath") -gt 0 ]; then
		content=$(cat $backupFilePath)
		echo "$content" > "$DB_FILE_PATH"
	else
		echo "No backup file found"
	fi	
}

find() {
	checkIfShouldCreateFileOrExit "$DB_FILE_PATH"
	read -p "Type username " username
	whatToFind="^$username"
	result=$(grep $whatToFind "$DB_FILE_PATH" -w)
	if [ "$result" ]; then
		echo "$result"
	else
		echo "User not found"
	fi
}

list() {
	checkIfShouldCreateFileOrExit "$DB_FILE_PATH"
	case $1 in
		"--inverse") cat -b "$DB_FILE_PATH" | tail -r;;
				  *) cat -b "$DB_FILE_PATH"
	esac
}

case $1 in
	"add") add;;
	"backup") backup;;
	"restore") restore;;
	"find") find;;
	"list") list $2;;
	"help") echo "Available commands are: add, backup, find, list, help";;
		 *) echo "'$1' is not supported script command. Run it with help argument to see which arguments are available"
esac