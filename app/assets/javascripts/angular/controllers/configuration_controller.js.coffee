angular.module('app.rubyops').classy.controller
  name: 'ConfigurationController'
  inject: ['$scope', '$http']

  init: ->
    @$.serverTypes = [
      label: 'nginx + unicorn'
      id: 'nginx_unicorn'
     # ,
     #  label: 'nginx + passenger'
     #  id: 'nginx_passenger'
    ]
    @$.shareTypes = [ 'NFS', 'VirtualBox' ]
    @$.postgresqlExtensions =
      [ { name: 'hstore' },
        { name: 'citext' },
        { name: 'postgis' } ]
    @$.osList = [
      { box: 'ubuntu/precise32', name: 'Ubuntu Precise Pangolin 12.04 LTS 32' },
      { box: 'ubuntu/precise64', name: 'Ubuntu Precise Pangolin 12.04 LTS 64' },
      { box: 'ubuntu/trusty32', name: 'Ubuntu Trusty 14.04 LTS 32' },
      { box: 'ubuntu/trusty64', name: 'Ubuntu Trusty 14.04 LTS 64' }
    ]
    @$.coresList = [ '1', '2', '3', '4' ]
    @$.rubyInstalls =
      rvm:
        label: 'RVM'
        rubies: [ 
                  { version: '1.8.6',    label: '1.8.6' },
                  { version: '1.8.7',    label: '1.8.7' },
                  { version: '1.9.1',    label: '1.9.1' },
                  { version: '1.9.2',    label: '1.9.2' },
                  { version: '1.9.3',    label: '1.9.3' },
                  { version: '2.0.0',    label: '2.0.0' },
                  { version: '2.1.1',    label: '2.1.1' },
                  { version: '2.1.2',    label: '2.1.2' },
                  { version: '2.1.3',    label: '2.1.3' },
                  { version: '2.1.4',    label: '2.1.4' },
                  { version: '2.1.5',    label: '2.1.5', default: true },
                  { version: '2.2.0',    label: '2.2.0' },
                  { version: '2.2-head', label: '2.2-head' },
                ]
      package:
        label: 'System package'
        # https://www.brightbox.com/docs/ruby/ubuntu/
        rubies: [ { version: 'ruby1.8',   label: '1.8' },
                  { version: 'ruby1.9.1', label: '1.9.1' },
                  { version: 'ruby2.1',   label: '2.1', default: true },
                  { version: 'ruby2.2',   label: '2.2 (beta)' } ]
    @$.railsVersions = [
      { version: '2',   label: 'rails 2.0+' },
      { version: '3', label: 'rails 3.0+' },
      { version: '4',   label: 'rails 4.0+' }
    ]

    @$.allObjects = []
    @$.activeObjects = []

    @$.packages =
      graphics:
        label: 'Graphics kit'
        packages: [ 'imagemagick' ]
      qt:
        label: 'QT kit'
        packages: [ 'qt5-default', 'libqt5webkit5-dev' ]
      curl:
        label: 'curl'
        packages: [ 'curl', 'libcurl3', 'libcurl3-gnutls', 'libcurl4-openssl-dev' ]

    @$.isActive = (obj) ->
      obj in @activeObjects

    @$.allActive = ->
      @activeObjects.length == @allObjects.length

    @$.add = (obj) ->
      @activeObjects.push obj

    @$.delete = (obj) ->
      @activeObjects = @activeObjects.filter (curObj) -> curObj isnt obj

  watch:
    'configuration.vm_name': '_onVmNameChanged'

  downloadConfiguration: (url) ->
    @$http.get(url).success (data) => @_loadConfiguration(data)

  _loadConfiguration: (configuration) ->
    @$.configuration = configuration
    @$.configuration.vm_os = (@$.osList.filter (os) -> os.box == configuration.vm_os)[0]
    @$.configuration.vm_ports = (val for key, val of configuration.vm_ports)
    p.selected = (id in configuration.package_bundles) for id, p of @$.packages
    @$.configuration.rails_version = (@$.railsVersions.filter (v) -> v.version == configuration.rails_version)[0]
    @$.configuration.ruby_version = (@$.rubyInstalls[@$.configuration.ruby_install].rubies.filter (v) -> v.version == configuration.ruby_version)[0]
    ext.selected = (ext.name in configuration.postgresql_extensions) for ext in @$.postgresqlExtensions

  _onVmNameChanged: (newValue, oldValue) ->
    if @$.configuration
      for dependant in ['delayed_job', 'sidekiq', 'resque']
        if @$.configuration["#{dependant}_app_name"] is undefined || @$.configuration["#{dependant}_app_name"] == "#{oldValue}-#{dependant}"
          @$.configuration["#{dependant}_app_name"] = "#{newValue}-#{dependant}"

      for db in [ 'postgresql', 'mysql', 'mongodb' ]
        if @$.configuration["#{db}_db_name"] is undefined || @$.configuration["#{db}_db_name"] == oldValue
          @$.configuration["#{db}_db_name"] = newValue
