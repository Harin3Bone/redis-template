#!/bin/bash

echo "Creating Redis environment..."

cp default.env .env

for i in 1 2 3
do 
    echo "."
    sleep 1
done

echo "Starting Redis server..."

docker-compose up -d 

for i in 1 2
do
    echo "."
    sleep 1 
done

echo "Starting Redis insight..."

docker-compose up -d 

for i in 1 2
do
    echo "."
    sleep 1 
done

echo "RabbitMQ server running http://localhost:5672"
echo "RabbitMQ management running http://localhost:15672"
echo "username: root"
echo "password: password"

sleep 1