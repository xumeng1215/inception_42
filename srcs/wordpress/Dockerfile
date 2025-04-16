# wordpress/Dockerfile
FROM alpine:3.18

# Install required packages
RUN apk add --no-cache \
	php81 \
	php81-phar \
	php81-fpm \
	php81-mysqli \
	php81-json \
	php81-curl \
	php81-dom \
	php81-exif \
	php81-fileinfo \
	php81-mbstring \
	php81-openssl \
	php81-xml \
	php81-zip \
	curl \
	mysql-client\
	tar

# Download and extract WordPress
RUN mkdir -p /var/www/html && \
	curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
	tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
	rm /tmp/wordpress.tar.gz

# get wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp


# Configure PHP-FPM to listen on all interfaces
RUN sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php81/php-fpm.d/www.conf
# Configure PHP-FPM to get the correct environment variables
RUN sed -i 's/^;clear_env = no/clear_env = no/' /etc/php81/php-fpm.d/www.conf

# Set up a init script when the container starts as entrypoint
COPY init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

# Volume configuration
VOLUME /var/www/html
RUN chown -R nobody:nobody /var/www/html
RUN chmod -R 755 /var/www/html

EXPOSE 9000

ENTRYPOINT ["/tmp/init.sh"]
CMD ["php-fpm81", "-F"]