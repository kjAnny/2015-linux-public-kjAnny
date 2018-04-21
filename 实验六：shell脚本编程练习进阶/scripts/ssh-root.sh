#!/usr/bin/env expect

#ref:http://www.techpaste.com/2013/04/shell-script-automate-ssh-key-transfer-hosts-linux/
set host [lrange $argv 0 0]
set username [lrange $argv 1 1]
set password [lrange $argv 2 2]
set lusername [lrange $argv 3 3]

set timeout 10
spawn /usr/bin/ssh-keygen -R $host
spawn /usr/bin/ssh-copy-id -i /home/$lusername/.ssh/id_rsa.pub $username@$host
match_max 100000
expect "*?(yes/no)\?"
send -- "yes\r"
# Look for password prompt
expect {
"*?assword:*" { send -- "$password\r"; send -- "\r"; exp_continue }
eof { exit 1 }
"Now try*\r" { exit 0 }
timeout { exit 1 }
}
exit 0
