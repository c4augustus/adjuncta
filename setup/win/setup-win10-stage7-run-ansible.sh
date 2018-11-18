#!/bin/bash
cp -av . ../../../temp-adjuncta-setup-win
cd ../../../temp-adjuncta-setup-win/ansible
ansible-playbook -i ansible-inventory -vv ansible-main.yml
cd ../../adjuncta/setup/win
rm -fR ../../../temp-adjuncta-setup-win
