#!/bin/bash

sudo docker container stop longvinter
sudo docker container rm longvinter
sudo docker-compose --env-file .env up --build -d
