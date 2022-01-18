echo "Installing LSWS WHM Plugin";
cd /usr/src; curl https://www.litespeedtech.com/packages/cpanel/lsws_whm_plugin_install.sh | sh
echo "Installing OpenLiteSpeed";
wget https://openlitespeed.org/packages/openlitespeed-1.7.14.tgz --no-check-certificate;
tar -zxvf openlitespeed-*.tgz
cd openlitespeed
./install.sh
rm -rf openlitespeed*;
echo "Installing OpenLiteSpeed cPanel Integrator";
yum -y install libargon2
wget -q -O /usr/local/olscp.tar URL;
tar xvf /usr/local/olscp.tar -C /usr/local;
mv /usr/src/lsws /usr/src/lsws.bak;
mkdir -p /usr/src/lsws;
cp -R /usr/local/olscp/misc/lsws /usr/src/lsws/;
touch /usr/local/lsws/conf/cpanel-vhosts.conf;
touch /usr/local/lsws/conf/alias.conf;
rm -rf /usr/local/lsws/conf/httpd_config.conf;
cp -R /usr/local/olscp/misc/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf;
mv /usr/local/cpanel/whostmgr/docroot/cgi/lsws/WhmMod_LiteSpeed_Util.php /usr/local/cpanel/whostmgr/docroot/cgi/lsws/WhmMod_LiteSpeed_Util.php.bak
cp -R /usr/local/olscp/misc/WhmMod_LiteSpeed_Util.php /usr/local/cpanel/whostmgr/docroot/cgi/lsws/WhmMod_LiteSpeed_Util.php;
ln -s /usr/local/olscp/olscp /usr/bin/olscp
chown -R lsadm.nobody /usr/local/lsws/conf/*;
echo "Hooking OpenLiteSpeed cPanel Integrator with cPanel/WHM";
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/terminate.sh  --manual --category Whostmgr --event Accounts::Remove --stage=pre
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/create.sh  --manual --category Whostmgr --event Accounts::Create --stage=post
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/kill.sh  --manual --category Cpanel --event Api2::AddonDomain::deladdondomain --stage=pre  --escalateprivs 1
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/addon.sh  --manual --category Cpanel --event Api2::AddonDomain::addaddondomain --stage=pre --escalateprivs 1
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/unpark.sh --category=Cpanel --event=Api2::Park::unpark --escalateprivs=1 --stage=post --manual
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/parked.sh --category=Cpanel --event=Api2::Park::park --escalateprivs=1 --stage=post --manual
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/addsub.sh --category=Cpanel --event=Api2::SubDomain::addsubdomain --escalateprivs=1 --stage=post --manual
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/delsub.sh --category=Cpanel --event=Api2::SubDomain::delsubdomain --escalateprivs=1 --stage=post --manual
# erase the rest
echo "Link Easyapache PHP into OLS";
/usr/local/cpanel/bin/manage_hooks add script /usr/local/olscp/scripts/php.sh --category=Cpanel --event=UAPI::LangPHP::php_set_vhost_versions --escalateprivs=1 --stage=pre --manual;
yum -y install ea-apache24-mod_lsapi.x86_64;
mv /usr/local/lsws/lsphp74/bin/lsphp /usr/local/lsws/lsphp74/bin/lsphp.bak;
cp -R /opt/cpanel/ea-php74/root/usr/bin/lsphp /usr/local/lsws/lsphp74/bin/lsphp;
mv /usr/local/lsws/lsphp74/bin/php /usr/local/lsws/lsphp74/bin/php.bak;
cp -R /opt/cpanel/ea-php74/root/usr/bin/php /usr/local/lsws/php74/bin/lsphp;
#a version
mkdir -p /usr/local/lsws/lsphp80/bin/;
cd /usr/local/lsws/lsphp80/bin/;
ln -s /opt/cpanel/ea-php80/root/bin/php php
ln -s /opt/cpanel/ea-php80/root/bin/lsphp lsphp

echo "This php is version 7.4, please enable lsapi on multiphp manager on WHM";
rm -rf /usr/local/olscp.tar

