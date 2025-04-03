# mariadb/Dockerfile
FROM alpine:3.18

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY init.sh /init.sh

RUN chmod +x /init.sh

VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/init.sh"]

CMD ["mysqld_safe"]