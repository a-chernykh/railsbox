#!/bin/bash

ansible-playbook $@ -i inventory ../ansible/deploy.yml
