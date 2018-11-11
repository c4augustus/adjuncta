#!/bin/bash
cp -av . ../../../../temp-adjuncta-setup-win
cd ../../../../temp-adjuncta-setup-win/ansible
ansible-playbook -i ansible-inventory -vv ansible/ansible-main.yml
