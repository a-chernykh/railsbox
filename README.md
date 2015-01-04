[railsbox][] is Ruby on Rails virtual machine configurator. You can quickly create virtual machine for development using this tool.

# Requirements

You will need [VirtualBox][], [vagrant][] and [ansible][] to bootstrap new machine using configuration created by this utility.

# What's included

## Operating systems

You can choose between Ubuntu 12.04 LTS and Ubuntu 14.04 LTS.

## Ruby versions

It's possible to install Ruby either with [rvm][] or using [brightbox apt repository][].

## Application server

Currently only [nginx][] in combination with [unicorn][] are supported. Some other servers will be added later.

## Databases

It's possible to install the following databases:

* PostgreSQL
* MySQL
* MongoDB
* redis

## Background jobs

* sidekiq
* resque
* delayed_job

[railsbox]: http://railsbox.io/
[vagrant]: https://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/
[ansible]: http://www.ansible.com/
[rvm]: https://rvm.io/
[brightbox apt repository]: https://www.brightbox.com/docs/ruby/ubuntu/
[nginx]: http://nginx.org/
[unicorn]: http://unicorn.bogomips.org/
