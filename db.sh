#!/usr/bin/env bash

add() {
	read -p "Type username " username
	read -p "Type role " role
	mkdir -p data
	echo "$username,$role" >> ./data/users.db
}

backup() {
	now=$(date +"%m_%d_%Y_%H_%M_%S")
	mkdir -p backups
	echo "now=$now"
	cp ./data/users.db "./backups/$now-users.db.backup"
}

case $1 in
	"add") add;;
	"backup") backup;;
	"help") echo "Available commands are: add, backup, find, list, help";;
	*) echo "'$1' is not supported script command. Run it with help argument to see which arguments are available"
esac

