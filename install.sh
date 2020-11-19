#!/bin/bash

OPTPATH=`pwd |grep /opt |wc -l`
if [ "$OPTPATH" -eq "0" ]; then
	   echo "Error!!!!" 
	   echo "Uncompress tar.gz in /opt/sysmonitor";
	      exit;
	  fi

echo "Installing dependences..."
sleep 1

apt-get install git python3 python3-pip python3-tzlocal python3-sdnotify python3-colorama
pip3 install -r /opt/sysmonitor/requirements.txt

echo "Customizing config.ini"
sleep 1
HOST=`hostname`
echo "sensor_name = $HOST" >> config.ini

echo "Enabling service..."
sleep 1
ln -s /opt/sysmonitor/sysmonitord.service /etc/systemd/system/sysmonitord.service 
systemctl daemon-reload
systemctl enable sysmonitord.service
systemctl start sysmonitord.service
sleep 3
systemctl restart sysmonitord.service
systemctl status sysmonitord.service
