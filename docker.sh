#!/usr/bin/env bash

if [ -z "$SUDO_USER" ]; then
    echo "Insufficient privileges. Please re-run this script as sudo"
    exit 1
fi

# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl gnupg
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

groupadd docker
usermod -aG docker $SUDO_USER
# Need to trigger a re-login to get the updated groups.
# Both options below only apply to the current script. Best solution is a reboot
#su - $USER
#newgrp docker

systemctl is-active docker || systemctl start docker
systemctl enable docker.service
systemctl enable containerd.service

chmod 0644 docker/files/elasticsearch*.yml

