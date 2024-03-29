IFS="$"
DOMAIN=$1
USER=$2
ADDON=$3
#VHOSTFILE="/usr/local/lsws/conf/vhosts/$DOMAIN.conf"
VHOSTFILE="$DOMAIN.conf"
echo "include $VHOSTFILE" >> cpanel-vhosts.conf;
echo "# Generated by OLScP"             >> $VHOSTFILE;
echo " "                                >> $VHOSTFILE;
echo "virtualHost $DOMAIN-80 {"         >> $VHOSTFILE;
echo "  user                    $USER"  >> $VHOSTFILE;
echo "  group                   $USER"  >> $VHOSTFILE;
echo "  vhRoot                  /home/$USER" >> $VHOSTFILE;
echo "  allowSymbolLink         1" >> $VHOSTFILE;
echo "  enableScript            1" >> $VHOSTFILE;
echo "  restrained              1" >> $VHOSTFILE;
echo "  setUIDMode              2" >> $VHOSTFILE;
echo "  # listeners  listener1, listener2, listener3" >> $VHOSTFILE;
echo "  listeners Default-80" >> $VHOSTFILE;
echo "  #VirtualHost config settings" >> $VHOSTFILE;
echo "  docRoot                   /home/$USER/public_html/$ADDON" >> $VHOSTFILE
echo "  vhDomain                  $DOMAIN" >> $VHOSTFILE
echo "  vhAliases                 www.$DOMAIN" >> $VHOSTFILE
echo "  adminmails               webmaster@$DOMAIN" >> $VHOSTFILE
echo "  enableGzip                1" >> $VHOSTFILE
echo "  enableIpGeo               1" >> $VHOSTFILE
echo "  errorlog /var/log/httpd/domains/$DOMAIN.error.log {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo "    logLevel                NOTICE" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  accesslog /var/log/httpd/domains/$DOMAIN.log {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo '        logFormat               %a %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i"' >> $VHOSTFILE
echo "    logHeaders              5" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  accesslog /var/log/httpd/domains/$DOMAIN.bytes {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo "    logFormat               %O %I" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "#  scripthandler  {" >> $VHOSTFILE
echo "#    add                     lsapi:lsphp74 inc" >> $VHOSTFILE
echo "#    add                     lsapi:lsphp74 php" >> $VHOSTFILE
echo "#    add                     lsapi:lsphp74 phtml" >> $VHOSTFILE
echo "#    add                     lsapi:lsphp74 php74" >> $VHOSTFILE
echo "#  }" >> $VHOSTFILE
echo " " >> $VHOSTFILE
echo "scriptHandler{" >> $VHOSTFILE
echo "    add lsapi:lsphp  php" >> $VHOSTFILE
echo "}" >> $VHOSTFILE
echo " " >> $VHOSTFILE
echo "  phpIniOverride  {" >> $VHOSTFILE
echo "    php_admin_flag engine ON" >> $VHOSTFILE
echo "    php_admin_value sendmail_path '/usr/sbin/sendmail -t -i -f $USER@$DOMAIN'" >> $VHOSTFILE
echo "    php_admin_value open_basedir '/home/$USER/:/tmp:/var/tmp:/opt/alt/php74/usr/share/pear/:/dev/urandom:/usr/local/lib/php/:/usr/local/php74/lib/php/'" >> $VHOSTFILE
echo "    php_admin_value mail.log /home/$USER/.php/php-mail.log" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  rewrite  {" >> $VHOSTFILE
echo "    enable                  1" >> $VHOSTFILE
echo "    autoLoadHtaccess        1" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "        context /cgi-bin/ {" >> $VHOSTFILE
echo "                allowBrowse 1" >> $VHOSTFILE
echo "                location /home/$USER/public_html/cgi-bin/" >> $VHOSTFILE
echo "                type cgi" >> $VHOSTFILE
echo "        }" >> $VHOSTFILE
echo "  # include aliases" >> $VHOSTFILE
echo "#  include /usr/local/lsws/conf/httpd-alias.conf" >> $VHOSTFILE
echo "}" >> $VHOSTFILE
echo "" >> $VHOSTFILE
echo "virtualHost $DOMAIN-443 {" >> $VHOSTFILE
echo "  user                    $USER" >> $VHOSTFILE
echo "  group                   $USER" >> $VHOSTFILE
echo "  vhRoot                  /home/$USER" >> $VHOSTFILE
echo "  allowSymbolLink         1" >> $VHOSTFILE
echo "  enableScript            1" >> $VHOSTFILE
echo "  restrained              1" >> $VHOSTFILE
echo "  setUIDMode              2" >> $VHOSTFILE
echo "  # listeners  listener1, listener2, listener3" >> $VHOSTFILE
echo "  listeners Default-SSL" >> $VHOSTFILE
echo "  #VirtualHost config settings" >> $VHOSTFILE
echo "  docRoot                   /home/$USER/public_html/$ADDON" >> $VHOSTFILE
echo "  vhDomain                  $DOMAIN" >> $VHOSTFILE
echo "  vhAliases                 www.$DOMAIN" >> $VHOSTFILE
echo "  adminEmails               webmaster@$DOMAIN" >> $VHOSTFILE
echo "  enableGzip                1" >> $VHOSTFILE
echo "  enableIpGeo               1" >> $VHOSTFILE
echo "  errorlog /var/log/httpd/domains/$DOMAIN.error.log {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo "    logLevel                NOTICE" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  accesslog /var/log/httpd/domains/$DOMAIN.log {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo '        logFormat               %a %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i"' >> $VHOSTFILE
echo "    logHeaders              5" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  accesslog /var/log/httpd/domains/$DOMAIN.bytes {" >> $VHOSTFILE
echo "    useServer               0" >> $VHOSTFILE
echo "    logFormat               %O %I" >> $VHOSTFILE
echo "    rollingSize             0" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  scripthandler  {" >> $VHOSTFILE
echo "    add                     lsapi:lsphp74 inc" >> $VHOSTFILE
echo "    add                     lsapi:lsphp74 php" >> $VHOSTFILE
echo "    add                     lsapi:lsphp74 phtml" >> $VHOSTFILE
echo "    add                     lsapi:lsphp74 php74" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  phpIniOverride  {" >> $VHOSTFILE
echo "    php_admin_flag engine ON" >> $VHOSTFILE
echo "    php_admin_value sendmail_path '/usr/sbin/sendmail -t -i -f $USER@$DOMAIN'" >> $VHOSTFILE
echo "    php_admin_value open_basedir '/home/$USER/:/tmp:/var/tmp:/opt/alt/php74/usr/share/pear/:/dev/urandom:/usr/local/lib/php/:/usr/local/php74/lib/php/'" >> $VHOSTFILE
echo "    php_admin_value mail.log /home/$USER/.php/php-mail.log" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  rewrite  {" >> $VHOSTFILE
echo "    enable                  1" >> $VHOSTFILE
echo "    autoLoadHtaccess        1" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "        context /cgi-bin/ {" >> $VHOSTFILE
echo "                allowBrowse 1" >> $VHOSTFILE
echo "                location /home/$USER/public_html/$DOMAIN/cgi-bin/" >> $VHOSTFILE
echo "                type cgi" >> $VHOSTFILE
echo "        }" >> $VHOSTFILE
echo "  vhssl  {" >> $VHOSTFILE
echo "    keyFile                 /var/cpanel/ssl/domain_tls/$DOMAIN/combined" >> $VHOSTFILE
echo "    certFile                /var/cpanel/ssl/domain_tls/$DOMAIN/combined" >> $VHOSTFILE
echo "    certChain               1" >> $VHOSTFILE
echo "    sslProtocol             24" >> $VHOSTFILE
echo "  }" >> $VHOSTFILE
echo "  # include aliases" >> $VHOSTFILE
echo "#  include /usr/local/lsws/conf/httpd-alias.conf" >> $VHOSTFILE
echo "}" >> $VHOSTFILE
