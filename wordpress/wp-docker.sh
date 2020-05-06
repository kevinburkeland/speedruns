#!/bin/bash
#update the system
apt update && apt dist-upgrade -y
#install docker & such
apt install docker docker-compose -y
#does some cleanup
mkdir ~/wordpress
cd ~/wordpress
#never do this, super insecure, should be using a template that I could auto gen passwords for
wget https://kevinburkelandclass.s3.amazonaws.com/docker-compose.yml
#stand it up
docker-compose up