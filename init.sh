#!/bin/sh
set -e

touch /config/aria2.session

echo "Setting frp conf"

if [[ ! -e /config/frpc.ini ]]
then
  cp /config/frpc.ini.default /config/frpc.ini
  time=$(date '+%s')
  sed -i "s/aria2/aria2-${time}/g" /config/frpc.ini
fi
site=$(cat /config/frpc.ini | grep -i subdomain)

echo "Your frp $site"

exec /usr/bin/supervisord -c /config/supervisord.conf