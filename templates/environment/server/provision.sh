#!/bin/bash

set -e

ansible-playbook $@ -s -i inventory ../ansible/site.yml
