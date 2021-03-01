#!/bin/sh

sudo rm -rf /opt/valheim/server
sudo mkdir /opt/valheim/server
sudo chown -R $(id -u) /opt/valheim
sudo docker restart valheim