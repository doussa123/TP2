#!/bin/bash

docker network create wp_network

# HTTP container
docker build -t my-nginx -f ./http/Dockerfile .

# PHP-FPM container
docker build -t my-php-fpm -f ./script/Dockerfile .

# MySQL container
docker build -t my-mysql -f ./data/Dockerfile .

# Run MySQL container
docker container run -d --name db --network wp_network -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wppassword my-mysql

# Run PHP-FPM container
docker container run -d --name script --network wp_network -v "$(pwd)/src:/var/www/html" my-php-fpm

# Run NGINX container
#docker container run -d --name http --network wp_network --link script:script -p 8080:8080 -v "$(pwd)/src:/var/www/html" my-nginx
docker run -d --name http --network wp_network --link script:script -p 8080:8080 -v "$(pwd)/src:/var/www/html" my-nginx

echo "Containers are running. You can now access WordPress at http://localhost:8080"
