FROM debian:stable-slim

RUN apt-get update
RUN apt-get install -y nginx nginx-extras

VOLUME /webdav
EXPOSE 80

COPY nginx.conf    /etc/nginx
COPY webdav.conf   /etc/nginx/conf.d
COPY entrypoint.sh /

CMD sh /entrypoint.sh && nginx -g "daemon off;"
