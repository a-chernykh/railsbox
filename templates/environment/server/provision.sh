#!/bin/bash

ansible-playbook $@ -s -i inventory ../ansible/site.yml
