echo "nameserver 192.185.2.2
nameserver 192.185.2.3
nameserver 192.168.122.1
" > /etc/resolv.conf

apt-get update -y  
apt-get install nano -y
apt-get install lynx -y