#!/bin/bash
## created 3 docker conteiners with
## redis
## mysql (root pass: 123456)
## memcached

docker run -d --name redis -p 6379:6379 redis:latest
docker run -d --name db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456  mysql:latest
docker run -d --name memcache -p 11211:11211 memcached:latest


