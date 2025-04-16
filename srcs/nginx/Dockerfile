FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl


# Generate self-signed TLS certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=mexu.42.fr"

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]