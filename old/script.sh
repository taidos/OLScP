#!/bin/bash
# vhosts no /etc/apache2/conf/httpd.conf
# colocar no /usr/local/lsws/conf/httpd_config.conf.txt
# /var/cpanel/userdata/centos/cache
# grep cPanel-username /etc/userdomains
# instalar o yum -y install libargon2.x86_64 ea-libargon2.x86_64 ea-libargon2-devel.x86_64 libargon2-devel.x86_64
# /var/cpanel/ssl/domain_tls/streamilive.tk/combined
#  /var/cpanel/userdata/username/ e  ls | grep .centos.tk | head -n 1 - ver subdominios?
#
# monitor: 1º ver todos os users, ls /var/cpanel/userdata/ | grep -v nobody , 
# 2º ver todos os dominios dele: cat /var/cpanel/userdata/user/cache | awk '{print $1}' | sed 's/.$//'
# depois comparar com as vhosts ja feitas e senao fazer
# parece mais ou menos isto: (azar do crl com os subdominios aqui, rever melhor
#  cat /var/cpanel/userdata/centos/cache | awk '{print $1}' | sed 's/.$//' | grep -v $(ls /usr/local/lsws/conf/vhosts | grep -v conf0 | grep -v Example | sed 's/.....$//')
# melhorado mas aqui vai burrar pk esta sempre a dar valor, caso nao tenha criado o subdominio pode dar
# cat /var/cpanel/userdata/centos/cache | awk '{print $1}' | sed 's/.$//' | grep -v $(ls /usr/local/lsws/conf/vhosts | grep -v conf0 | grep -v Example | sed 's/.....$//' | shuf -n 1)
DOMAIN=$(cat /etc/trueuserdomains | awk '{print $1}' | sed 's/.$//')
USER=$(cat /etc/trueuserdomains | sed 's/^.*: //')
