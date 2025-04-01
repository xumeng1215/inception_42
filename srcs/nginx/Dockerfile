# nginx/Dockerfile
FROM alpine:3.18

RUN apk add --no-cache nginx openssl

# Generate self-signed TLS certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /var/www/html


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]