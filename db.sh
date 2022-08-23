#!/usr/bin/env bash


add() {
	read -p "Type username " username
	read -p "Type role " role
	echo "$username,$role" >> ./data/users.db
}

if [[ $1 == "add" ]]; then
	echo "argument $1"
    add
else
	echo "argument $1"
	echo "Not supported script command. Run it with help argument to see which arguments are available"
fi