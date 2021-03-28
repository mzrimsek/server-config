#/bin/bash

sudo rm config.yml
sudo wget https://raw.githubusercontent.com/mzrimsek/server-config/main/dashboard/config.yml
sudo docker container restart homer