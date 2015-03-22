angular
  .module('app.railsbox')
  .constant 'OPERATING_SYSTEMS', [
      { box: 'ubuntu/precise32', name: 'Ubuntu Precise Pangolin 12.04 LTS 32' },
      { box: 'ubuntu/precise64', name: 'Ubuntu Precise Pangolin 12.04 LTS 64' },
      { box: 'ubuntu/trusty32',  name: 'Ubuntu Trusty 14.04 LTS 32' },
      { box: 'ubuntu/trusty64',  name: 'Ubuntu Trusty 14.04 LTS 64' }
    ]
