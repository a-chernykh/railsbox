# https://www.brightbox.com/docs/ruby/ubuntu/
angular
  .module('app.railsbox')
  .constant 'SYSTEM_PACKAGE_RUBIES', [
      { version: 'ruby1.8',   label: '1.8' },
      { version: 'ruby1.9.1', label: '1.9.1' },
      { version: 'ruby2.1',   label: '2.1', default: true },
      { version: 'ruby2.2',   label: '2.2 (beta)' }
    ]
