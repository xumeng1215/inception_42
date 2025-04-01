# mariadb/Dockerfile
FROM alpine:3.18

RUN apk add --no-cache mariadb mariadb-client

COPY init.sql /docker-entrypoint-initdb.d/init.sql

# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["mysqld", "--user=mysql"]