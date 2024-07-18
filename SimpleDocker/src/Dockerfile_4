FROM ubuntu:latest

RUN apt update && apt install -y \
    build-essential \
    libfcgi-dev \
    nginx \
    spawn-fcgi

COPY server/server.c /app/server.c

COPY server/nginx/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app

RUN gcc -o server server.c -lfcgi

CMD spawn-fcgi -a 127.0.0.1 -p 8080 -f ./server && nginx -g "daemon off;"

EXPOSE 8080
