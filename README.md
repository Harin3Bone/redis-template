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
| REDIS_VERSION | 6.2.5 | String | Redis image version |
| REDIS_PORT | 6379 | number | Redis server port |
| REDIS_PASSWORD | password | String | Redis server password |
| INSIGHT_VERSION | latest | String | RedisLabs image version |
| INSIGHT_PORT | 8001 | number | RedisLabs server port |
| TIMEZONE | "Asia/Bangkok" | String | Server timezone |

## Setup
**Step 1:** Add `Redis` service into your `docker-compose.yml`
```yaml
services:
  redis:
    image: redis:${REDIS_VERISON:-6.2.5}
    command: redis-server --requirepass ${REDIS_PASSWORD:-password}
    container_name: redis
    networks:
      - net
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: always
```

**Step 2:** Add `Redis Insight` service into your `docker-compose.yml`
```yaml
  redis-insight:
    image: redislabs/redisinsight:${INSIGHT_VERSION:-latest}
    container_name: redis-insight
    volumes:
      - vol:/db
    networks:
      - net
    ports:
      - ${INSIGHT_PORT:-8001}:8001
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    depends_on:
      - redis
    restart: always
```

**Step 3:** Add the network description
```yaml
volumes:
  vol:
    driver: local
```

**Step 4:** Add the network description
```yaml
networks:
  net:
    driver: bridge
```

Then `docker-compose.yml` will look like this
```yaml
version: "3.8"

services:
  redis:
    image: redis:${REDIS_VERISON:-6.2.5}
    command: redis-server --requirepass ${REDIS_PASSWORD:-password}
    container_name: redis
    networks:
      - net
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: always

  redis-insight:
    image: redislabs/redisinsight:${INSIGHT_VERSION:-latest}
    container_name: redis-insight
    volumes:
      - vol:/db
    networks:
      - net
    ports:
      - ${INSIGHT_PORT:-8001}:8001
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    depends_on:
      - redis
    restart: always

volumes:
  vol:
    driver: local

networks:
  net:
    driver: bridge
```

**Step 5:** Start server
```bash
docker-compose up -d
```

## Redis Configuration File
**Step 1** Download `redis.conf` template to set advance configuration of `Redis` from this link [Click here](https://redis.io/topics/config)

**Step 2** Edit `Redis` service in `docker-compose.yml` into this
```yaml
  redis:
    image: redis:${REDIS_VERISON:-6.2.5}
    command: redis-server --requirepass ${REDIS_PASSWORD:-password}
    container_name: redis
    volumes:
      - ./redis.conf:/etc/redis/redis.conf.default
    networks:
      - net
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: always
```

**Step 3:** Start server
```bash
docker-compose up -d
```
> ### **Actually** 
> in new `docker-compose.yml` just change from pulling raw image to build image by `Dockerfile` because i just want to copy `redis.conf` into redis

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
[Redislabs](https://docs.redislabs.com/latest/ri/installing/install-docker/)<br>
[Configuration](https://redis.io/topics/config)

## Contributor
<a href="https://github.com/Harin3Bone"><img src="https://img.shields.io/badge/Harin3Bone-181717?style=flat&logo=github&logoColor=ffffff"></a>
