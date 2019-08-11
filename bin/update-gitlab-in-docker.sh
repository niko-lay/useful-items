#!/bin/bash
set -e

STORAGE_PATH=${GITLAB_STORAGE_PATH:-/srv/gitlab} # default value
BACKUP_PATH=${GITLAB_BACHUP_PATH:-/var/storage/backup/gitlab} # default value
HOST_NAME=${GITLAB_HOST_NAME} # nesesary

if [[ -z "${HOST_NAME}" ]]; then
    echo "Varible 'GITLAB_HOST_NAME' not avaliable. Exiting..."
    exit 1
fi

echo "Current running..."
docker ps --filter "name=gitlab"
cur_ver=$(docker  ps --format "{{.Image}}" --filter "name=gitlab" | cut -d : -f2)

read -p "Enter new version: " new_ver

if [[ "$cur_ver" == "$new_ver" ]];
then
    echo "curret runing version '${cur_ver}'  and requested are equals, exitting..."
    exit 1
fi

echo "Downloaging new version..."
docker pull gitlab/gitlab-ce:${new_ver} > /dev/null

echo "Making copy of current gitlab volumes..."
sudo cp -r ${STORAGE_PATH} ${BACKUP_PATH}/gitlab_$(date --iso)

docker stop gitlab
docker rename gitlab gitlab-$(date --iso)



docker run --detach  --hostname ${HOST_NAME}  \
    --publish 127.0.0.1:1443:443 --publish 127.0.0.1:1080:80 --publish 22:22 \
    --name gitlab  --restart unless-stopped \
    --volume ${STORAGE_PATH}/config:/etc/gitlab  --volume ${STORAGE_PATH}/logs:/var/log/gitlab  --volume ${STORAGE_PATH}/data:/var/opt/gitlab \
    gitlab/gitlab-ce:${new_ver}
