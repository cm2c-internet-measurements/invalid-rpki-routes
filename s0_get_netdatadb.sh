#!/bin/bash

# d='20181231'

d=$1

echo Invoke as: ./s0_get_netdatadb.sh YYYYMMDD
echo date is $d

wget -c --output-document=var/netdata-$d.db \
    http://trantor.labs.lacnic.net/carlos/netdata/netdata-$d.db

cd var

ln -sf netdata-$d.db netdata-latest.db 
