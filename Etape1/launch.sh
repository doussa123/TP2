#!/bin/bash

# Create a custom Docker network
docker network create mon_network

# Build the NGINX image
docker build -t my-nginx -f ./http/Dockerfile .

# Build the PHP-FPM image
docker build -t my-php-fpm -f ./script/Dockerfile .

# Run the PHP-FPM container
docker container run -d --name script --network mon_network my-php-fpm

# Run the NGINX container and link it to the PHP-FPM container
docker container run -d --name http --network mon_network --link script:script -p 8080:8080 -v "$(pwd)/src:/app" my-nginx