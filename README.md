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
