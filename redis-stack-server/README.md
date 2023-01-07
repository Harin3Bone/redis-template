# Docker for Redis
![Redis](https://img.shields.io/badge/Redis-DC382D?&style=flat&logo=redis&logoColor=FFFFFF)
![Docker](https://img.shields.io/badge/Docker-2496ED?&style=flat&logo=docker&logoColor=ffffff)

## Description
This repository made for build simple of Redis with docker

## Additional Detail
This compose file using `redis/redis-stack-server` they also have many useful module include:
- RedisSearch
- RedisJSON
- RedisGraph
- RedisTimeSeries
- RedisBloom

## Prerequisite
* [Docker](https://docs.docker.com/engine/install/ubuntu/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start
```bash
time ./quick-start.sh
```

## Default Value
Create `.env` file to define your own value

| Variable name   | Default value | Datatype |             Description |
|:----------------|:--------------|:--------:|------------------------:|
| REDIS_VERSION   | 7.0.6-RC3     |  String  |     Redis image version |
| REDIS_PORT      | 6379          |  number  |       Redis server port |
| INSIGHT_VERSION | 1.13.1        |  String  |   Redis insight version |
| INSIGHT_PORT    | 8001          |  String  |      Redis insight port |
| REDIS_PASSWORD  | password      |  String  |   Redis server password |
| TIMEZONE        | 1.13.0        |  String  | RedisLabs image version |

## Setup Redis

**Step 1:** Add `Redis` service into your `docker-compose.yml`
```yaml
services:
  redis-stack-server:
    image: redis/redis-stack-server:${REDIS_VERSION:-7.0.6-RC3}
    container_name: redis-stack-server
    networks:
      - redis_network
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      REDIS_ARGS: "--requirepass ${REDIS_PASSWORD:-password}"
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: on-failure
```
**Step 2:** Add the network configuration
```yaml
networks:
  redis_network:
    name: redis_network
    driver: bridge
```

**Step 3:** If you want to bind persistence disk you can add `volumes` in **redis** services like this

```yaml
  redis-stack-server:
    image: redis/redis-stack-server:${REDIS_VERSION:-7.0.6-RC3}
    container_name: redis-stack-server
    volumes:
      - redis_server_volume:/data
    networks:
      - redis_network
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      REDIS_ARGS: "--requirepass ${REDIS_PASSWORD:-password}"
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: on-failure
```
Please add volume configuration as well

```yaml
volumes:
  redis_server_volume:
    name: redis_server_volume
    driver: local
```

> **Tips**
>
> This step is an optional, not required

**Step 4:** If you want to have something to make sure that your redis have start successfully please add `healthcheck` in **redis**

```yaml
  redis-stack-server:
    image: redis/redis-stack-server:${REDIS_VERSION:-7.0.6-RC3}
    container_name: redis-stack-server
    healthcheck:
      test: [ "CMD", "redis-cli", "--raw", "incr", "ping" ]
      interval: 5s
      timeout: 30s
      retries: 3
    volumes:
      - redis_server_volume:/data
    networks:
      - redis_network
    ports:
      - ${REDIS_PORT:-6379}:6379
    environment:
      REDIS_ARGS: "--requirepass ${REDIS_PASSWORD:-password}"
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    restart: on-failure
```

> **Tips**
>
> This step is an optional, not required

**Step 5:** Start server
```bash
docker-compose up -d
```

## Setup Redis Insight

**Step 1:** Add `Redis Insight` service into your `docker-compose.yml`

```yaml
  redis-insight:
    image: redislabs/redisinsight:${INSIGHT_VERSION:-1.13.0}
    container_name: redis-insight
    volumes:
      - redis_insight_volume:/db
    networks:
      - redis_network
    ports:
      - ${INSIGHT_PORT:-8001}:8001
    environment:
      TZ: ${TIMEZONE:-"Asia/Bangkok"}
    depends_on:
      - redis
    restart: always
```

**Step 2:** Add `Redis Insight` volume
```yaml
volumes:
  redis_insight_volume:
    name: redis_insight_volume
    driver: local
```

**Step 3:** Start server
```bash
docker-compose up -d
```

> **Important**
>
> Please make sure `redis` and `redis-insight` are at the same network group
> If they're not in same group `redis-insight` will not found `redis` server.

## Redis Configuration File
**Step 1** Download `redis.conf` template to set advance configuration of `Redis` from this link [Click here](https://redis.io/docs/management/config-file/)

**Step 2** Edit `Redis` service in at `volume` section in `docker-compose.yml` like this
```yaml
  redis-stack-server:
    image: redis/redis-stack-server:${REDIS_VERSION:-7.0.6-RC3}
    container_name: redis-stack-server
    volumes:
      - ./redis.conf:/redis-stack.conf
      - redis_server_volume:/data
    networks:
      - redis_network
    ports:
      - ${REDIS_PORT:-6379}:6379
    restart: on-failure
```

> **Tips**
>
> If you have redis.conf you can move `REDIS_ARGS` environment into redis.conf instead
>
> **Example**
> ```redis.conf
> requirepass <your password>
> ``` 

**Step 4:** Start server
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
[Redis Stack](https://redis.io/docs/stack/get-started/install/docker/)<br>
[RedisLabs](https://docs.redislabs.com/latest/ri/installing/install-docker/)<br>
[Configuration Example](https://redis.io/docs/management/config-file/)<br>
[Configuration Doc](https://redis.io/topics/config)

## Contributor
[![Harin3Bone](https://img.shields.io/badge/Harin3Bone-181717?style=flat&logo=github&logoColor=ffffff)](https://github.com/Harin3Bone)
