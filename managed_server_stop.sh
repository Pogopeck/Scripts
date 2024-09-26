#!/bin/bash

#Stop ARM managed server
export pid_mgd=`ps -ef |grep cal09|grep =CramerServer1|grep -v grep|awk '{print $2}'`
kill -9 $pid_mgd
cd /home/cal09/JEE/CramerDomain/WLS/CramerDomain && rm nohup.CramerServer1*

#validate whether the process stopeed or not
export pc=`ps -ef |grep cal09|grep =CramerServer1|grep -v grep|wc -l`

if [[ $pc = 0 ]];
then
echo "CramerServer1 is stopped"
else
echo "CramerServer1 is running"
fi
pwd
sh backuplogs.sh
