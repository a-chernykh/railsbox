[railsbox][] is Ruby on Rails virtual machine configurator. You can quickly create virtual machine for development using this tool.

# Requirements

You will need [VirtualBox][], [vagrant][] and [ansible][] to bootstrap new machine using configuration created by this utility. You can install everything quickly with [homebrew][] and [brew cask][]:

```bash
brew install caskroom/cask/brew-cask
brew cask install virtualbox
brew cask install vagrant
brew install ansible
```

# What's included

## Operating systems

You can choose between Ubuntu 12.04 LTS and Ubuntu 14.04 LTS. Base boxes provided by [vagrantcloud.com][].

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

# Future plans

[railsbox][] is constantly improving. The following is in our TODO list for future releases:

* Multi-environment support (ability to apply the same playbooks for production / staging)
* Add ability to deploy to various platforms supported by vagrant - Parallels, VMWare, EC2
* Add additional server options (Passenger, puma, thin)
* Add memcached
* Add elasticsearch
* Add MariaDB
* Add CouchDB
* Add SMTP server

# Contributing

[railsbox]: http://railsbox.io/
[vagrant]: https://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/
[ansible]: http://www.ansible.com/
[rvm]: https://rvm.io/
[brightbox apt repository]: https://www.brightbox.com/docs/ruby/ubuntu/
[nginx]: http://nginx.org/
[unicorn]: http://unicorn.bogomips.org/
[homebrew]: http://brew.sh/
[brew cask]: https://github.com/caskroom/homebrew-cask
[vagrantcloud]: http://vagrantcloud.com
