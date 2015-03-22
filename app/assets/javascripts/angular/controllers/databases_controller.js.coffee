angular
  .module('app.railsbox')
  .controller 'DatabasesController', ($scope, DATABASES) ->
    $scope.allObjects = DATABASES
    $scope.bindToConfiguration 'databases'

    $scope.$watch 'configuration.mongodb_orm', (newValue) ->
      $scope.mongodbConfigPath = switch newValue
        when 'mongoid' then 'config/mongoid.yml'
        when 'mongomapper' then 'config/mongo.yml'

    onSqlOrmChanged = (newValue) ->
      if $scope.configuration
        $scope.configuration.postgresql_orm = $scope.configuration.mysql_orm = newValue
      $scope.sqlConfigPath = switch newValue
        when 'activerecord', 'sequel', 'datamapper' then 'config/database.yml'

    $scope.$watch 'configuration.mysql_orm', onSqlOrmChanged
    $scope.$watch 'configuration.postgresql_orm', onSqlOrmChanged
