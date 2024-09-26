#!/bin/bash

#Stop ARM managed server
export pid_mgd=`ps -ef |grep cal09|grep =CramerServer2|grep -v grep|awk '{print $2}'`
kill -9 $pid_mgd
cd /home/cal09/JEE/CramerDomain/WLS/CramerDomain && rm nohup.CramerServer2*

#validate whether the process stopeed or not
export pcm=`ps -ef |grep cal09|grep =CramerServer2|grep -v grep|wc -l`

if [[ $pcm = 0 ]];
then
echo "CramerServer2 is stopped"
else
echo "CramerServer2 is running"
fi

#Stop ARM admin server
export pid_adm=`ps -ef |grep cal09|grep adminServer|grep -v grep|awk '{print $2}'`
kill -9 $pid_adm

#validate whether the process stopeed or not
export pca=`ps -ef |grep cal09|grep adminServer|grep -v grep|wc -l`

if [[ $pca = 0 ]];
then
echo "adminServer is stopped"
else
echo "adminServer is running"
fi

pwd
sh backuplogs.sh
