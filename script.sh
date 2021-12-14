#!/bin/bash
# vhosts no /etc/apache2/conf/httpd.conf
# colocar no /usr/local/lsws/conf/httpd_config.conf.txt
# instalar o yum -y install libargon2.x86_64 ea-libargon2.x86_64 ea-libargon2-devel.x86_64 libargon2-devel.x86_64
DOMAIN=$(cat trueuserdomains | awk '{print $1}' | sed 's/.$//')
USER=$(cat /etc/trueuserdomains | sed 's/^.*: //')

