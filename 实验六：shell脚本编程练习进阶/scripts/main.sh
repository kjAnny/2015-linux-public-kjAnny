#!/bin/bash
source global-var.sh

expect ssh-root.sh $ip $username $password $localuser

scp global-var.sh $username@$ip:
ssh $username@$ip 'bash -s' < install.sh

bash sed-conf.sh

scp conf/proftpd.conf $username@$ip:/etc/proftpd/
scp conf/exports $username@$ip:/etc/exports
scp conf/smb.conf $username@$ip:/etc/samba/smb.conf
scp conf/interfaces $username@$ip:/etc/network/interfaces
scp conf/isc-dhcp-server $username@$ip:/etc/default/isc-dhcp-server
scp conf/dhcpd.conf $username@$ip:/etc/dhcp/dhcpd.conf
scp conf/db.cuc.edu.cn $username@$ip:/etc/bind/db.cuc.edu.cn
scp conf/named.conf.local $username@$ip:/etc/bind/named.conf.local

ssh $username@$ip 'bash -s' < do-conf.sh
