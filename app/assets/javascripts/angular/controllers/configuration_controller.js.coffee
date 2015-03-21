angular.module('app.railsbox').controller 'ConfigurationController', ['$scope', '$http', ($scope, $http) ->
  _findOptionById = (options, id, label) -> (options.filter (opt) -> opt[label] == id)[0]

  _t = (key) -> I18n.t("boxes.form.#{key}")

  $scope.serverTypes = [
    label: _t('nginx_unicorn')
    id: 'nginx_unicorn'
   ,
    label: _t('nginx_puma')
    id: 'nginx_puma'
   ,
    label: _t('nginx_passenger')
    id: 'nginx_passenger'
  ]
  $scope.shareTypes = [
    label: _t('nfs')
    id: 'nfs'
   , 
    label: _t('virtualbox')
    id: ''
   ,
    label: _t('smb')
    id: 'smb'
  ]
  $scope.postgresqlExtensions =
    [ { name: 'hstore' },
      { name: 'citext' },
      { name: 'postgis' } ]
  $scope.osList = [
    { box: 'ubuntu/precise32', name: 'Ubuntu Precise Pangolin 12.04 LTS 32' },
    { box: 'ubuntu/precise64', name: 'Ubuntu Precise Pangolin 12.04 LTS 64' },
    { box: 'ubuntu/trusty32', name: 'Ubuntu Trusty 14.04 LTS 32' },
    { box: 'ubuntu/trusty64', name: 'Ubuntu Trusty 14.04 LTS 64' }
  ]
  $scope.coresList = [ '1', '2', '3', '4', '5', '6', '7', '8' ]

  rubies = [ { version: '1.8.6',    label: '1.8.6' },
             { version: '1.8.7',    label: '1.8.7' },
             { version: '1.9.1',    label: '1.9.1' },
             { version: '1.9.2',    label: '1.9.2' },
             { version: '1.9.3',    label: '1.9.3' },
             { version: '2.0.0',    label: '2.0.0' },
             { version: '2.1.1',    label: '2.1.1' },
             { version: '2.1.2',    label: '2.1.2' },
             { version: '2.1.3',    label: '2.1.3' },
             { version: '2.1.4',    label: '2.1.4' },
             { version: '2.1.5',    label: '2.1.5' },
             { version: '2.2.0',    label: '2.2.0' },
             { version: '2.2.1',    label: '2.2.1', default: true },
             { version: '2.2-head', label: '2.2-head' }, ]

  $scope.rubyInstalls =
    rvm:
      label: _t('rvm')
      rubies: rubies
    rbenv:
      label: _t('rbenv')
      rubies: rubies
    package:
      label: _t('system_package')
      # https://www.brightbox.com/docs/ruby/ubuntu/
      rubies: [ { version: 'ruby1.8',   label: '1.8' },
                { version: 'ruby1.9.1', label: '1.9.1' },
                { version: 'ruby2.1',   label: '2.1', default: true },
                { version: 'ruby2.2',   label: '2.2 (beta)' } ]
  $scope.railsVersions = [
    { version: '2',   label: 'rails 2.0+' },
    { version: '3',   label: 'rails 3.0+' },
    { version: '4',   label: 'rails 4.0+' }
  ]

  $scope.packages =
    graphics:
      label: _t('graphics_kit')
      packages: [ 'imagemagick' ]
    qt:
      label: _t('qt_kit')
      packages: [ 'qt5-default', 'libqt5webkit5-dev' ]
    curl:
      label: _t('curl')
      packages: [ 'curl', 'libcurl3', 'libcurl3-gnutls', 'libcurl4-openssl-dev' ]

  _updateVmName = (newValue, oldValue) ->
    if $scope.configuration
      if $scope.configuration.path == "/#{oldValue}"
        $scope.configuration.path = "/#{newValue}"

      for dependant in ['delayed_job', 'sidekiq', 'resque']
        if $scope.configuration["#{dependant}_app_name"] is undefined || $scope.configuration["#{dependant}_app_name"] == "#{oldValue}-#{dependant}"
          $scope.configuration["#{dependant}_app_name"] = "#{newValue}-#{dependant}"

      for db in [ 'postgresql', 'mysql', 'mongodb' ]
        if $scope.configuration["#{db}_db_name"] is undefined || $scope.configuration["#{db}_db_name"] == oldValue
          $scope.configuration["#{db}_db_name"] = newValue

  _updatePath = (newValue, oldValue) ->
    if $scope.configuration?.environment_file == "#{oldValue}/.envrc"
      $scope.configuration['environment_file'] = "#{newValue}/.envrc"

  _updateRubyInstall = (newValue, oldValue) ->
    if oldValue and newValue
      $scope.configuration.ruby_version = ($scope.rubyInstalls[newValue].rubies.filter (v) -> v.default)[0]

  $scope.loadConfiguration = (configuration) ->
    $scope.configuration = configuration
    _updateVmName configuration.vm_name, undefined
    _updatePath configuration.path, undefined
    _updateRubyInstall configuration.ruby_install, undefined

    $scope.configuration.vm_os = _findOptionById($scope.osList, configuration.vm_os, 'box')

    for environment in ['development', 'staging', 'production']
      if $scope.configuration[environment]
        $scope.configuration[environment].vm_ports = (val for key, val of configuration[environment].vm_ports)
        $scope.configuration[environment].vm_share_type = _findOptionById($scope.shareTypes, configuration[environment].vm_share_type, 'id')

    p.selected = (id in configuration.package_bundles) for id, p of $scope.packages
    $scope.configuration.rails_version = _findOptionById($scope.railsVersions, configuration.rails_version, 'version')
    $scope.configuration.ruby_version = ($scope.rubyInstalls[$scope.configuration.ruby_install].rubies.filter (v) -> v.version == configuration.ruby_version)[0]
    ext.selected = (ext.name in configuration.postgresql_extensions) for ext in $scope.postgresqlExtensions

  $scope.downloadConfiguration = (url) ->
    $http.get(url).success (data) => $scope.loadConfiguration(data)

  $scope.$watch 'configuration.vm_name', _updateVmName
  $scope.$watch 'configuration.path', _updatePath
  $scope.$watch 'configuration.ruby_install', _updateRubyInstall
]
