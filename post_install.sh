#!/bin/sh -x
IP_ADDRESS=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')

cd /usr/local/bin
ln -s python3.7 python

cd /usr/local/share && git clone https://github.com/nosmokingbandit/Watcher3.git

mv Watcher3 watcher

pw user add media -c media -u 710 -d /nonexistent -s /usr/bin/nologin
chown -R media:media watcher

cp /usr/local/share/watcher/run\ scripts/FreeBSD/watcher /usr/local/etc/rc.d/watcher
chmod 755 /usr/local/etc/rc.d/watcher

sysrc watcher_enable=YES
sysrc watcher_data_dir="/usr/local/share/watcher"

service watcher start

echo -e "Watcher now installed.\n" > /root/PLUGIN_INFO
echo -e "\nGo to http://$IP_ADDRESS:9090\n" >> /root/PLUGIN_INFO