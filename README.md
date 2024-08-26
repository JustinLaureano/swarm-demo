# Swarm Demo

## Installation

```bash

git clone <url>

cd swarm-demo

docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www" \
    -w /var/www \
    laravelsail/php83-composer:latest \
    composer install --ignore-platform-reqs


cp .env.example .env

sail up -d

sa key:generate

sa migrate

sail npm install

```


## Builds

Build app php-fpm server and push to repo

```bash
docker build --no-cache -t justinlaureano/swarm-demo-app:latest -f ./Dockerfile --build-arg user=laravel --build-arg uid=1000 .


docker push justinlaureano/swarm-demo-app:latest
```

Build web server and push to repo

```bash
docker build --no-cache -t justinlaureano/swarm-demo-web:latest --target=prod -f ./docker-compose/nginx/Dockerfile .

docker push justinlaureano/swarm-demo-web:latest
```


Build mysql server and push to repo

```bash
docker build --no-cache -t justinlaureano/swarm-demo-mysql:latest -f ./docker-compose/mysql/Dockerfile .

docker push justinlaureano/swarm-demo-mysql:latest
```



Copy over compe file to manager node

```bash
scp docker-compose.prod.yml user@1.2.3.4:/usr/src

scp docker-compose.monitor.yml user@1.2.3.4:/usr/src
```


run stack on manager node

```bash
export $(cat .env)

docker stack deploy -c docker-compose.prod.yml demo
```


run monitoring stack on manager node

```bash
docker stack deploy -c docker-compose.monitor.yml monitor
```

view monitoring on port `8080` of manager server ip address


Other commands

```bash
docker stack ls

docker service ls

docker service ps demo_app
docker service ps demo_web
docker service ps demo_mysql

docker service logs demo_app
docker service logs demo_web
docker service logs demo_mysql

docker container ls
docker exec -it demo_app.1.<ID> bash

docker stack rm demo
```
