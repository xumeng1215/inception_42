#!/bin/sh

set -e
echo "-------------Initialize MariaDB data directory if empty"
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "-------------Start MariaDB server in the background"
mysqld_safe --skip-networking &
pid="$!"

sleep 5

echo "-------------Wait for MariaDB to be ready"
until mysqladmin ping --silent --socket=/var/run/mysqld/mysqld.sock; do
    echo "Waiting..."
    sleep 2
done

echo "-------------Create database and users"
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "-------------Stop the background MariaDB server"
mysqladmin shutdown

echo "-------------Comment out the 'skip-networking' line"
sed -i "s/^skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf

echo "-------------Uncomment the 'bind-address=0.0.0.0' line"
sed -i "s/^#bind-address=0.0.0.0/bind-address=0.0.0.0/" /etc/my.cnf.d/mariadb-server.cnf

echo "-------------Start MariaDB server in the foreground CMD"
exec "$@"