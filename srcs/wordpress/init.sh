#!/bin/sh

# Check if wp-config.php exists
# If it doesn't, create it from wp-config-sample.php
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "-----------wp-config.php not found. Creating from wp-config-sample.php..."
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # Replace placeholders with environment variables
    sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
    sed -i "s/username_here/$WP_DB_USER/" /var/www/html/wp-config.php
    sed -i "s/password_here/$WP_DB_PASSWORD/" /var/www/html/wp-config.php
    sed -i "s/localhost/$DB_HOST/" /var/www/html/wp-config.php


	# wp --info
	# wp config create \
    #     --dbname="$DB_NAME" \
    #     --dbuser="$WP_DB_USER" \
    #     --dbpass="$WP_DB_PASSWORD" \
    #     --dbhost="$DB_HOST" \
    #     --path=/var/www/html \
    #     --skip-check

    echo "-----------wp-config.php has been configured."

	else
	echo "-----------wp-config.php already exists."
fi

# Wait for the database to be ready
echo "-----------Waiting for the database to be ready..."
until mysql -h"$DB_HOST" -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&1; do
    sleep 2
done
echo "-----------Database is ready."

if ! wp core is-installed --path=/var/www/html; then
    echo "-----------Installing WordPress..."
    wp core install \
        --url="$SITE_URL" \
        --title="$SITE_TITLE" \
        --admin_user="$WP_USER1" \
        --admin_password="$WP_PASSWORD1" \
        --admin_email="$WP_EMAIL1" \
        --skip-email \
        --path=/var/www/html

    echo "-----------WordPress installed successfully."

    # Create a normal user
    echo "-----------Creating a normal user..."
    wp user create "$WP_USER2" "$WP_EMAIL2" \
        --role=author \
        --user_pass="$WP_PASSWORD2" \
        --path=/var/www/html
    echo "-----------Normal user created successfully."
else
    echo "-----------WordPress is already installed."
fi

# Start PHP-FPM
exec "$@"