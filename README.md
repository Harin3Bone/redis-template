# Docker for Redis
<img alt="Redis" src="https://img.shields.io/badge/Redis-DC382D?&style=flat&logo=redis&logoColor=FFFFFF">&nbsp;
<img alt="Docker" src="https://img.shields.io/badge/Docker-2496ED?&style=flat&logo=docker&logoColor=ffffff">&nbsp;

## Description
This repository made for build simple of Redis with docker.

## Prerequisite
* [Docker](https://docs.docker.com/engine/install/ubuntu/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start
```bash
time ./quick-start.sh
```

## Default Value
Create `.env` file to define your own value
| Variable name | Defualt value | Datatype | Description |
|:--------------|:--------------|:--------:|------------:|
| REDIS_PORT | 6379 | number | Redis server port |
| REDIS_PASSWORD | password | String | Redis server password |
| INSIGHT_PORT | 8001 | number | Redis manage port |

## Setup
**Step 1:** Add `Redis` node into your `docker-compose.yml`
```yaml
version: '3.3'

services:
  redis:
    image: redis
    command: redis --requirepass ${REDIS_PASSWORD}
    container_name: redis
    networks:
      - net
```
**Step 2:** Add default port of redis in ports
```yaml
    ports:
      - ${REDIS_PORT}:6379
```
**Step 3:** Add `Redis Insight` node into your `docker-compose.yml`
```yaml
  redis-insight:
    image: redislabs/redisinsight:latest
    container_name: redis-insight
    volumes:
      - vol:/db
    networks:
      - net
```
**Step 4:** Add default port of redis insight in ports
```yaml
    ports:
      - ${INSIGHT_PORT}:8001
```
**Step 5:** Add the volume description
```yaml
volumes:
  vol:
    driver: local
```
**Step 6:** Add the network description
```yaml
networks:
  net:
    driver: bridge
```
**Step 7:** Copy `default.env` to `.env` for define value
```bash
cp default.env .env
```
By the way you can rename `default.env` to `.env` as well
```bash
mv -f defualt.env .env
```

Then `docker-compose.yml` will look like this
```yaml
version: '3.3'

services:
  redis:
    image: redis
    command: redis --requirepass ${REDIS_PASSWORD}
    container_name: redis
    networks:
      - net
    ports:
      - ${REDIS_PORT}:6379

  redis-insight:
    image: redislabs/redisinsight:latest
    container_name: redis-insight
    volumes:
      - vol:/db
    networks:
      - net
    ports:
      - ${INSIGHT_PORT}:8001

volumes:
  vol:
    driver: local

networks:
  net:
    driver: bridge
```
**Step 8:** Start server
```bash
docker-compose up -d
```

## Redis CLI
Run docker command to access redis server
```bash
docker exec -it redis redis-cli
```
After access to redis-cli you should be see interface like this
```
127.0.0.1:6379>
```
And then before do anything you must login first.
```
AUTH [username] [password]
```
Example
```
AUTH default password
```

## Reference
[Docker Hub](https://hub.docker.com/_/redis)<br>
[Redis](https://redis.io/commands)<br>
[Redislabs](https://docs.redislabs.com/latest/ri/installing/install-docker/)

## Contributor
<a href="https://github.com/Harin3Bone"><img src="https://img.shields.io/badge/Harin3Bone-181717?style=flat&logo=github&logoColor=ffffff"></a>
