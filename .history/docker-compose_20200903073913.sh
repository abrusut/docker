#!/bin/sh
ENV_FILE=.env

# Checking if .env file exists
if [ ! -f $ENV_FILE ]; then
    echo ".env not found, creating it..."
    cp env.example $ENV_FILE
fi

# Reading .env file and setting vars on it
#set -o allexport; source ./$ENV_FILE; set +o allexport # POSIX compatible, not working
export $(grep -v '^#' $ENV_FILE | xargs -d '\n') # Other way to do it

echo "Setting some vars..."
sed -i "s/UID=1000/UID=$(id -u)/g" $ENV_FILE
sed -i "s|HOME=\/home\/user|HOME=$HOME|g" $ENV_FILE # Using pipe '|' because $HOME has '/' in it
sed -i "s/COLUMNS=80/COLUMNS=$(tput cols)/g" $ENV_FILE

# Checking virtual_hosts folder
if [ ! -d $VIRTUAL_HOSTS ]; then
    echo "$VIRTUAL_HOSTS folder not found, creating it..."
    mkdir -p $VIRTUAL_HOSTS
fi

# Checking virtual_hosts folder
if [ ! -d $VIRTUAL_HOSTS7 ]; then
    echo "$VIRTUAL_HOSTS7 folder not found, creating it..."
    mkdir -p $VIRTUAL_HOSTS7
fi

# Checking apache logs folder
if [ ! -d $APACHE_LOGS ]; then
    echo "$APACHE_LOGS folder not found, creating it..."
    mkdir -p $APACHE_LOGS
fi

docker-compose -f docker-compose.yml $@
