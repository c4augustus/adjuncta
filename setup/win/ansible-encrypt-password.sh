#!/bin/bash
# from htps://docs.ansible.com/ansible/2.7/reference_appendices/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module
ansible all -i localhost, -m debug -a "msg={{ 'mypassword' | password_hash('sha512', 'mysecretsalt') }}"
