FROM redis
ARG conf
COPY ${conf} /etc/redis/redis.conf.default
