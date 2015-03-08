#!/bin/bash

ansible-playbook $@ -u root -s -i production site.yml
