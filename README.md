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
docker-compose up -d
```

## Setup
**Step 1:** Add `Redis` node into your `docker-compose.yml`
```yaml
version: '3.3'

services:
  redis:
    image: redis
    container_name: redis
    networks:
      - redis-net
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
      - redis-vol:/db
    networks:
      - redis-net
```
**Step 4:** Add default port of redis insight in ports
```yaml
    ports:
      - ${INSIGHT_PORT}:8001
```
**Step 5:** Add the volume description
```yaml
volumes:
  redis-vol:
    driver: local
```
**Step 6:** Add the network description
```yaml
networks:
  redis-net:
    driver: bridge
```

Then `docker-compose.yml` will look like this
```yaml
version: '3.3'

services:
  redis:
    image: redis
    container_name: redis
    networks:
      - redis-net
    ports:
      - 6379:6379

  redis-insight:
    image: redislabs/redisinsight:latest
    container_name: redis-insight
    volumes:
      - redis-vol:/db
    networks:
      - redis-net
    ports:
      - 8001:8001

volumes:
  redis-vol:
    driver: local

networks:
  redis-net:
    driver: bridge
```

## Reference
[Docker Hub](https://hub.docker.com/_/redis)<br>
[Redislabs](https://docs.redislabs.com/latest/ri/installing/install-docker/)

## Contributor
<a href="https://github.com/Harin3Bone"><img src="https://img.shields.io/badge/Harin3Bone-181717?style=flat&logo=github&logoColor=ffffff"></a>
