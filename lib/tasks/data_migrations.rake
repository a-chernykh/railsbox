namespace :data_migrations do
  desc 'Migrate boxes to the new multi-environment format'
  task environments: :environment do
    DataMigrations::Environments.new(Logger.new(STDOUT)).run
  end
end
