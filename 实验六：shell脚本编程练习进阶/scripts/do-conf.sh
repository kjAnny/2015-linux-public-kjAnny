#!/bin/bash

source /root/global-var.sh

#ProFTPD
# 创建虚拟用户的本地ftp文件夹
if [ ! -d "$PRO_VIR_DIR" ] ; then
  mkdir $PRO_VIR_DIR
fi
if [ ! -d "$PRO_FTPASSWD_DIR" ] ; then
  mkdir $PRO_FTPASSWD_DIR
fi
# 修改/home/virtual权限
chown -R $PRO_UID:$PRO_GID $PRO_VIR_DIR
chmod -R 700 $PRO_VIR_DIR

# 创建了一个用户
/usr/bin/expect << EOF
spawn ftpasswd --passwd --file=$PRO_PASSWD_DIR --name=$PRO_VIRTUAL_USER --uid=$PRO_UID --home=$PRO_VIR_DIR --shell=/bin/false
expect {
 "Password:" {send "${PRO_VIRTUAL_PASS}\r"; exp_continue}
 "Re-type password:" {send "${PRO_VIRTUAL_PASS}\r";}
}
expect eof
EOF

# 创建了一个virtualusers组
ftpasswd --file=$PRO_GROUP_DIR --group --name=$PRO_GROUP_NAME --gid=$PRO_GID

ftpasswd --group --name=$PRO_GROUP_NAME --gid=$PRO_GID --member=$PRO_VIRTUAL_USER --file=$PRO_GROUP_DIR


# 创建Samba共享专用的用户
# 创建的用户必须有一个同名的Linux用户，密码是独立的
useradd -M -s /sbin/nologin $SAMBA_USERNAME
/usr/bin/expect << EOF
spawn passwd $SAMBA_USERNAME
expect {
 "*password:" {send "${SAMBA_PASSWORD}\r"; exp_continue}
 "*password:" {send "${SAMBA_PASSWORD}\r";}
}
spawn smbpasswd -a $SAMBA_USERNAME
expect {
 "*password:" {send "${SAMBA_PASSWORD}\r"; exp_continue}
 "*password:" {send "${SAMBA_PASSWORD}\r";}
}
EOF

smbpasswd -e $SAMBA_USERNAME
# 创建用户组
sudo groupadd $SAMBA_GROUP
# 添加用户组
sudo usermod -G $SAMBA_GROUP $SAMBA_USERNAME

# 创建文件夹
if [ ! -d "$SAMBA_GUEST_DIR" ] ; then
  mkdir -p $SAMBA_GUEST_DIR
fi
if [ ! -d "$SAMBA_DEMO_DIR" ] ; then
  mkdir -p $SAMBA_DEMO_DIR
fi

chgrp -R $SAMBA_GROUP $SAMBA_GUEST_DIR
chgrp -R $SAMBA_GROUP $SAMBA_DEMO_DIR

chmod 2775 $SAMBA_GUEST_DIR
chmod 2770 $SAMBA_DEMO_DIR

# 启动Samba
smbd -s stop
smbd

# NFS
NFS_GEN_DIR="/var/nfs/general"
if [ ! -d "$NFS_GEN_DIR" ] ; then
  mkdir $NFS_GEN_DIR -p
fi
chown nobody:nogroup $NFS_GEN_DIR

#DHCP
sudo systemctl restart networking.service
systemctl start isc-dhcp-server
#DNS
systemctl restart bind9.service

service proftpd restart
systemctl restart nfs-kernel-server
