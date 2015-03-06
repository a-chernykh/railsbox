#!/bin/bash

ansible-playbook $@ -s -i inventory ../ansible/deploy.yml
