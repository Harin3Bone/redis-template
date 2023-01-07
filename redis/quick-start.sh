#!/bin/bash

echo "Creating Redis environment..."

cp default.env .env

for i in 1 2 3
do 
    echo "."
    sleep 1
done

echo "Starting Redis Stack Server..."

docker-compose up -d redis-stack-server

for i in 1 2
do
    echo "."
    sleep 1 
done

echo "Starting Redis Insight..."

docker-compose up -d redis-insight

sleep 1

rm .env

echo "Redis server running http://localhost:6379"
echo "Redis insight running http://localhost:8001"
echo "username: default"
echo "password: password"

sleep 1
