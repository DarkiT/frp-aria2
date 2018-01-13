#!/bin/sh
set -e

touch /config/aria2.session

echo "Setting frp confing"

if [[ ! -e /config/frpc.ini ]]
then
  cp /etc/frpc.ini.default /config/frpc.ini
  time=$(date '+%s')
  sed -i "s/aria2/aria2-${time}/g" /config/frpc.ini
fi

echo "[DONE]"

if [ "$FRP_STATUS" = "on" ];then
	echo "Starting frp"
	site=$(cat /config/frpc.ini | grep -i subdomain)
	echo "Your frp $site"
	frpc -c /config/frpc.ini &
fi

echo "Setting Aria2 confing"

if [[ ! -e /config/aria2.conf ]]
then
  cp /etc/aria2.conf.default /config/aria2.conf
fi
echo "[DONE]"
echo "Starting aria2c"
exec aria2c --conf-path=/config/aria2.conf