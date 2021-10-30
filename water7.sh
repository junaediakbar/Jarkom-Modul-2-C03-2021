echo "nameserver 192.168.122.1" > /etc/resolv.conf 
apt-get update -y  
apt-get install dnsutils -y
apt-get install bind9 -y
apt-get install nano -y
echo "
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include /etc/bind/zones.rfc1918;

zone \"franky.c03.com\" {
    type slave;
    masters { 192.185.2.2; }; // Masukan IP EniesLobby tanpa tanda petik
    file \"/var/lib/bind/franky.c03.com\";
};

zone \"mecha.franky.c03.com\" {
        type master;
        file \"/etc/bind/sunnygo/mecha.franky.c03.com\";
};

"> /etc/bind/named.conf.local
echo "
options {
        directory \"/var/cache/bind\";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable 
        // nameservers, you probably want to use them as forwarders.  
        // Uncomment the following block, and insert the addresses replacing 
        // the all-0's placeholder.

        // forwarders {
        //      0.0.0.0;
        // };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        //dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};


"> /etc/bind/named.conf.options
mkdir -p /etc/bind/sunnygo

echo "
\$TTL    604800
@       IN      SOA     mecha.franky.c03.com. root.mecha.franky.c03.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      mecha.franky.c03.com.
@               IN      A       192.185.2.4
www             IN      CNAME   mecha.franky.c03.com.
general         IN      A       192.185.2.4
www.general     IN      CNAME   general.mecha.franky.c03.com.
" > /etc/bind/sunnygo/mecha.franky.c03.com

service bind9 start
service bind9 restart