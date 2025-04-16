FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

VOLUME /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod -R 755 /var/lib/mysql

ENTRYPOINT ["/tmp/init.sh"]

CMD ["mysqld_safe"]