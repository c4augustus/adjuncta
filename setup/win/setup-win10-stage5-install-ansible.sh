#!/bin/bash
# [c4augustus] based on https://plenium.wordpress.com/2017/11/20/install-ansible-on-windows-10
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
