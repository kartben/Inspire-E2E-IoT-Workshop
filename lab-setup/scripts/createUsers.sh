#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: ./createUsers.sh [domain] [password] [number]"
    exit 1
fi

domain=$1
password=$2
nb=${3:-150} # default is to create 150 users

for i in $(seq -w 1 $nb)
do
    echo Creating user$i@$domain
    az ad user delete --upn-or-object-id user$i'@'$domain 
    az ad user create --user-principal-name user$i'@'$domain --display-name 'User '$i --password $password -o none --force-change-password-next-login false
done