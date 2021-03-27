#!/bin/bash

sudo docker container stop jenkins
sudo docker container rm jenkins
sudo docker pull jenkins/jenkins:lts
sudo docker-compose --env-file .env up --build -d