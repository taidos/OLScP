#!/bin/bash
echo -e "===============  OLScP - Starting the vhost creation            =============="
echo -e "===============  Creating all the cPanel main vhosts for OLS  ================"
echo -e "------------------------------------------------------------------------------"

cat /etc/trueuserdomains | sed 's/^.*: //' | while read CPUSER; do
DOMAIN=$(cat /etc/trueuserdomains | grep $CPUSER | awk '{print $1}' | sed 's/.$//')
echo "Now processing ${CPUSER} with the domain $DOMAIN..."
/usr/local/olscp/olscp create $DOMAIN ${CPUSER};

done
echo -e "------------------------------------------------------------------------------"
echo -e "===============    Processing Addon Domain vhosts for OLS     ================"
echo -e "------------------------------------------------------------------------------"
cat /etc/trueuserdomains | sed 's/^.*: //' | while read ADDONUSER; do
cat /var/cpanel/userdata/$ADDONUSER/cache | grep addon | awk '{print $1}' | sed 's/.$//' | while read ADDONDOMAIN; do
echo "Now processing ${ADDONUSER} with the domain ${ADDONDOMAIN}..."
/usr/local/olscp/olscp addon ${ADDONDOMAIN} ${ADDONUSER};
done
done

echo -e "------------------------------------------------------------------------------"
echo -e "===============     Processing Subdomain's vhosts for OLS     ================"
echo -e "------------------------------------------------------------------------------"
cat /etc/trueuserdomains | sed 's/^.*: //' | while read SUBUSER; do
cat /var/cpanel/userdata/$SUBUSER/cache | grep sub | awk '{print $1}' | sed 's/.$//' | while read SUBDOMAIN; do
FOLDER=$(cat /var/cpanel/userdata/$SUBUSER/cache | grep ${SUBDOMAIN} | cut -f5- -d/ | sed 's/\==.*/==/'  | sed 's/..$//' | head -1)
echo "Now processing ${SUBUSER} with the domain ${SUBDOMAIN} on the folder $FOLDER..."
/usr/local/olscp/olscp addsub ${SUBDOMAIN} ${SUBUSER} $FOLDER;
done
done

echo -e "------------------------------------------------------------------------------"
echo -e "===============    Processing Parked Domain vhosts for OLS     ================"
echo -e "------------------------------------------------------------------------------"
cat /etc/trueuserdomains | sed 's/^.*: //' | while read PARKEDUSER; do
cat /var/cpanel/userdata/$PARKEDUSER/cache | grep parked | awk '{print $1}' | sed 's/.$//' | while read PARKEDDOMAIN; do
echo "Now processing ${PARKEDUSER} with the domain ${PARKEDDOMAIN}..."
/usr/local/olscp/olscp create ${PARKEDDOMAIN} ${PARKEDUSER};
done
done