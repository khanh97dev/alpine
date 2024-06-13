#!/bin/sh
echo "install: mysql...\n"

apk add --no-cache mysql mysql-client

echo "init...\n"
/etc/init.d/mariadb setup

sed -i 's/^skip-networking/#&/' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/^bind-address=0.0.0.0/#&/' /etc/my.cnf.d/mariadb-server.cnf

echo "[client]" >> /etc/my.cnf
echo "user=root" >> /etc/my.cnf
echo "password=root" >> /etc/my.cnf

if ! command -v openrc &> /dev/null
then
  curl -o- https://raw.githubusercontent.com/khanh97dev/alpine/main/install-openrc.sh | bash -x
fi

rc-update add mariadb

rc-service mariadb restart

# grant root to global network
mysql -u root -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root'"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root -proot -e "FLUSH PRIVILEGES;"
