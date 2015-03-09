angular.module('app.railsbox').controller 'DatabasesController', ['$scope', ($scope) ->
  $scope.allObjects = [
    { id: 'postgresql', name: I18n.t('boxes.form.postgresql') },
    { id: 'mysql',      name: I18n.t('boxes.form.mysql') },
    { id: 'mongodb',    name: I18n.t('boxes.form.mongodb') },
    { id: 'redis',      name: I18n.t('boxes.form.redis') },
  ]
  $scope.activeObjects = []

  $scope.$watch 'configuration.mongodb_orm', (newValue) ->
    $scope.mongodbConfigPath = switch newValue
      when 'mongoid' then 'config/mongoid.yml'
      when 'mongomapper' then 'config/mongo.yml'

  $scope.$watch 'configuration.databases', (newValue) ->
    if $scope.configuration and $scope.configuration.databases
      $scope.activeObjects = $scope.configuration.databases

  onSqlOrmChanged = (newValue) ->
    if $scope.configuration
      $scope.configuration.postgresql_orm = $scope.configuration.mysql_orm = newValue
    $scope.sqlConfigPath = switch newValue
      when 'activerecord', 'sequel', 'datamapper' then 'config/database.yml'

  $scope.$watch 'configuration.mysql_orm', onSqlOrmChanged
  $scope.$watch 'configuration.postgresql_orm', onSqlOrmChanged
]
