#!/bin/bash

## stat/stop 3 docker conteiners
## redis
## mysql
## memcahed


ACTION='';

case "$1" in 
start) ACTION='start' ;; 
stop) ACTION='stop' ;;

*) echo "Usage $0 start|stop"
   exit 1 ;;
esac

if [ -z ${DOCKER_MACHINE_NAME+x} ]; then
eval $(docker-machine env) ;
fi

if [ -z ${DOCKER_MACHINE_NAME+x} ]; then
echo 'Looks like docker-machine not running'
exit 1 ;
fi


docker $ACTION redis 
docker $ACTION db
docker $ACTION memcache

