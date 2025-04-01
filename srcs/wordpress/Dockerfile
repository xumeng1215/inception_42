# wordpress/Dockerfile
FROM alpine:3.18

# Install required packages
RUN apk add --no-cache \
	php81 \
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
	tar

# Download and extract WordPress
RUN mkdir -p /var/www/html && \
	curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
	tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
	rm /tmp/wordpress.tar.gz

RUN sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php81/php-fpm.d/www.conf

# Copy custom wp-config.php
COPY wp-config.php /var/www/html/wp-config.php

# Set permissions
RUN chown -R nobody:nobody /var/www/html

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm81", "-F"]