FROM nginx:1.27.1 AS base

COPY . /var/www

EXPOSE 80

FROM base AS dev
COPY ./fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

FROM base AS prod
COPY ./docker-compose/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./docker-compose/nginx/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /var/www/wait-for-it.sh
