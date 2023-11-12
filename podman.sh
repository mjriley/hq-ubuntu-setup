#!/usr/bin/env bash

sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/Release.key" \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg]\
    https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/ /" \
  | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null
sudo apt-get update -qq


# Clean previous podman installations, just in case
#sudo rm -f /etc/systemd/system/podman.service
#sudo rm -f /etc/systemd/system/podman-restart.service
#sudo rm -f /etc/systemd/system/podman-auto-update.service
#sudo rm -f /etc/systemd/system/podman-auto-update.timer

#sudo rm -f /etc/systemd/user/podman.service
#sudo rm -f /etc/systemd/user/default.target.wants/podman.service
#sudo rm -f /etc/systemd/user/sockets.target.wants/podman.socket
#sudo rm -f /etc/xdg/systemd/user/podman.socket
#systemctl  --user daemon-reload

#Also look in /usr/lib/systemd/user/podman.socket
# /usr/lib/systemd/user/podman.service

sudo apt-get install -y podman podman-docker


# Install flatpak
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.podman_desktop.PodmanDesktop

export RESTART_REQUIRED=1
