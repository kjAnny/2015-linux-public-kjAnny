#!/bin/bash

ansible-playbook -i hosts site.yml --ask-vault-pass
