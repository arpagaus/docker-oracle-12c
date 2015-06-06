#!/bin/bash

mount -t tmpfs shmfs -o size=4g /dev/shm

while true; do
  status=`ps -ef | grep tns | grep oracle`
  pmon=`ps -ef | egrep pmon_$ORACLE_SID'\>' | grep -v grep`
  if [ "$status" == "" ] || [ "$pmon" == "" ]
  then
    sudo -u oracle -i bash -c "lsnrctl start"
    sudo -u oracle -i bash -c "sqlplus /nolog @?/config/scripts/startdb.sql"
    sudo -u oracle -i bash -c "lsnrctl status"
  fi
  sleep 1m
done;
