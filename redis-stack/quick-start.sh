#!/bin/bash

echo "Creating Redis environment..."

cp default.env .env

for i in 1 2 3
do 
    echo "."
    sleep 1
done

echo "Starting Redis Stack Service ..."

docker-compose up -d 

for i in 1 2
do
    echo "."
    sleep 1 
done

rm .env

sleep 1 

echo "Redis stack server running http://localhost:6379"
echo "Redis insight running http://localhost:8001"
echo "username: default"
echo "password: password"
