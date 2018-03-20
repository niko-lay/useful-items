#!/bin/bash

if [ -z ${1+x} ]; then
echo "Kernel version not provided. Usage: '$0 version'";
exit 1
fi

KERN=$1

re='^[0-9]+$'
if ! [[ $KERN =~ $re ]] ; then
   echo "error: '$KERN' not a number" >&2
   exit 1
fi

apt remove linux-headers-4.4.0-$KERN linux-headers-4.4.0-$KERN-generic linux-image-4.4.0-$KERN-generic linux-image-extra-4.4.0-$KERN-generic
