FROM ubuntu:latest

RUN apt update && apt install -y \
    build-essential \
    libfcgi-dev \
    nginx \
    spawn-fcgi && rm -rf /var/lib/apt/lists

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

COPY server/server.c /app/server.c

COPY server/nginx/nginx.conf /etc/nginx/nginx.conf

RUN chown -R appuser:appgroup /app /var /run

WORKDIR /app

RUN gcc -o server server.c -lfcgi

USER appuser

CMD spawn-fcgi -a 127.0.0.1 -p 8080 -f ./server && nginx -g "daemon off;"

#EXPOSE 8080

HEALTHCHECK CMD curl -f http://localhost:81/ || exit 1
