#!/bin/bash

ansible-playbook $@ -u railsbox -i production deploy.yml
