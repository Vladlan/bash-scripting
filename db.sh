#!/usr/bin/env bash

add() {
	read -p "Type username " username
	read -p "Type role " role
	echo "$username,$role" >> ./data/users.db
}

case $1 in
	"add") add;;
	"help") echo "Available commands are: add, backup, find, list, help";;
	*) echo "'$1' is not supported script command. Run it with help argument to see which arguments are available"
esac

