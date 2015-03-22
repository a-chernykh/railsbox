angular
  .module('app.railsbox')
  .controller 'ConfigurationController', 
   ($scope,
    $http,
    POSTGRESQL_EXTENSIONS,
    OPERATING_SYSTEMS,
    CORES,
    RUBIES,
    SERVER_TYPES,
    SHARE_TYPES,
    SYSTEM_PACKAGE_RUBIES,
    RAILS_VERSIONS) ->

    _findOptionById = (options, id, label) -> (options.filter (opt) -> opt[label] == id)[0]
    _t = (key) -> I18n.t("boxes.form.#{key}")
    _labelize = (array) -> { id: el, label: _t(el) } for el in array
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

    $scope.serverTypes = _labelize SERVER_TYPES
    $scope.shareTypes = _labelize SHARE_TYPES
    $scope.postgresqlExtensions = POSTGRESQL_EXTENSIONS
    $scope.osList = OPERATING_SYSTEMS
    $scope.coresList = CORES
    $scope.rubyInstalls =
      rvm:
        label: _t('rvm')
        rubies: RUBIES
      rbenv:
        label: _t('rbenv')
        rubies: RUBIES
      package:
        label: _t('system_package')
        rubies: SYSTEM_PACKAGE_RUBIES
    $scope.railsVersions = RAILS_VERSIONS

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
