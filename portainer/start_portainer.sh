#!/bin/bash

sudo docker container stop portainer
sudo docker container rm portainer
sudo docker pull portainer/portainer-ce:latest
sudo docker-compose --env-file .env up -d