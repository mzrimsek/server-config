#/bin/bash

sudo rm apps.json
sudo wget https://raw.githubusercontent.com/mzrimsek/server-config/main/dashboard/apps.json

sudo rm bookmarks.json
sudo wget https://raw.githubusercontent.com/mzrimsek/server-config/main/dashboard/bookmarks.json

sudo rm themes.json
sudo wget https://raw.githubusercontent.com/mzrimsek/server-config/main/dashboard/themes.json

sudo docker container restart dashboard
