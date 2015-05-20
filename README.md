# CryChat ( == Crypto Chat)



Requeried: PHP 5(+GD2) + Apache.

    # apt-get install apache2 php5 php5-gd curl

Files:

	# mkdir /var/www/crychat
	# cp -R www/* /var/www/crychat/*
	# chmod 777 -R /var/www/crychat/

# directory with session files:

	# chown www-data:www-data /var/lib/php5

# Checker

checker-crychat.sh

# Checker input params

	COMMAND=$1
	HOST=$2
	ID=$3
	FLAG=$4

# Example checker call 

	#!/bin/bash

	echo "TEST PUT"
	./checker-crychat.sh put 127.0.0.1 someid3 4FE93926-55E6-47E7-9089-9BDED570B631
	echo "TEST GET"
	./checker-crychat.sh get 127.0.0.1 someid3 4FE93926-55E6-47E7-9089-9BDED570B631
	echo "TEST CHECK"
	./checker-crychat.sh check 127.0.0.1

# Returned code errors

	exit(104) service in down
	exit(103) service is broken
	exit(103) service is broken
	exit(101) good

# Other example

	https://raw.githubusercontent.com/HackerDom/ructfe-2014/master/checkers/pidometer.checker.py