#!/bin/bash
echo `date` > /tmp/user_data.txt
#echo "candidate@2024" | passwd --stdin root
echo "root:candidate@2024" | sudo chpasswd
sudo apt update -y &&
sudo apt install -y nginx