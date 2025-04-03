#!/bin/sh

set -e

# Start MariaDB server in the background
mysqld_safe --skip-networking &
pid="$!"

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

# Create database and users
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Stop the background MariaDB server
mysqladmin shutdown


# Start MariaDB server in the foreground
exec "$@"