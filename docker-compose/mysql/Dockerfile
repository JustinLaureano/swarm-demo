FROM mysql:8.0.33

ARG password

COPY ./docker-compose/mysql/create_database.sql /docker-entrypoint-initdb.d/create_database.sql
RUN echo "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${password}';" >> /docker-entrypoint-initdb.d/set_native_password.sql