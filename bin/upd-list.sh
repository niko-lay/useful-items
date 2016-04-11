#!/bin/bash

apt-get update > /dev/null; echo Hostname: `hostname`; lsb_release -d; uname -a; echo 'uptime:' `uptime`; echo; apt-get upgrade -s -V | awk '/The following packages/ { output=1 } output { print } /upgraded.*newly installed/ { output=0 }'
