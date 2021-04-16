#!/bin/bash

# https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-20-04/

sudo apt update
sudo apt install openssh-server
sudo ufw allow ssh