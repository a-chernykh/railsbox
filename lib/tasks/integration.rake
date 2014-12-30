require File.expand_path('../../../spec/support/test_helpers/params_fixtures', __FILE__)

namespace :integration do
  desc 'Builds new configuration and copies it to the test_app_path'
  task copy: :environment do
    include TestHelpers::ParamsFixtures
    test_app_path = '/Users/akhkharu/projects/testapp'
    configurator = Configurator.from_params(params_fixture)
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
