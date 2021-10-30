echo "nameserver 192.168.122.1" > /etc/resolv.conf 
apt-get install apache2 -y
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y
apt-get install wget -y
apt-get install unzip -y
apt-get install apache2-utils -y

mkdir /var/www/franky.c03.com
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/franky.zip
unzip franky.zip
mv franky/* /var/www/franky.c03.com
rm -r franky


## memberikan alias dari home 
echo "
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/franky.c03.com
        ServerName franky.c03.com
        ServerAlias www.franky.c03.com

        <Directory /var/www/franky.c03.com/>
                Options +Indexes
        </Directory>
 
        Alias \"/home\" \"/var/www/franky.c03.com/index.php/home\"

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/franky.c03.com.conf

a2ensite franky.c03.com
a2enmod rewrite
service apache2 restart


echo "
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/super.franky.c03.com
        ServerName super.franky.c03.com
        ServerAlias www.super.franky.c03.com

        <Directory /var/www/super.franky.c03.com/public>
                Options +Indexes
        </Directory>

        #<Directory /var/www/super.franky.c03.com/public/*>
        #        Options -Indexes
        #</Directory>
        Alias \"/js\" \"/var/www/super.franky.c03.com/public/js\"

        ErrorDocument 404 /error/404.html
        <Files \"/var/www/super.franky.c03.com/error/404.html\">
                <If \"-z %{ENV:REDIRECT_STATUS}\">
                        RedirectMatch 404 ^/error/404.html$
                </If>
        </Files>

         <Directory /var/www/super.franky.c03.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/super.franky.c03.com.conf

mkdir /var/www/super.franky.c03.com
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/super.franky.zip
unzip super.franky.zip
mv super.franky/* /var/www/super.franky.c03.com
rm -r super.franky
echo '
RewriteEngine On
RewriteCond %{REQUEST_URI} !^/public/images/franky.png$
RewriteCond %{REQUEST_FILENAME} !-d 
RewriteRule ^(.*)franky(.*)$ /public/images/franky.png [R=301,L]
' > /var/www/super.franky.c03.com/.htaccess

a2ensite super.franky.c03.com

htpasswd -b -c /var/www/general.mecha.franky.c03 luffy onepiece

echo -e "Listen 15000 \nListen 15500" >> /etc/apache2/ports.conf

echo "
<VirtualHost *:15000 *:15500>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/general.mecha.franky.c03.com
        ServerName general.mecha.franky.c03.com
        ServerAlias www.general.mecha.franky.c03.com

        <Directory \"/var/www/general.mecha.franky.c03.com\">
                AuthType Basic
                AuthName \"Restricted Content\"
                AuthUserFile /var/www/general.mecha.franky.c03 
                Require valid-user
        </Directory>


        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/general.mecha.franky.c03.com.conf

mkdir /var/www/general.mecha.franky.c03.com
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/general.mecha.franky.zip
unzip general.mecha.franky.zip
mv general.mecha.franky/* /var/www/general.mecha.franky.c03.com
rm -r general.mecha.franky

a2ensite general.mecha.franky.c03.com

echo "
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        redirect permanent / http://franky.c03.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/000-default.conf

service apache2 restart