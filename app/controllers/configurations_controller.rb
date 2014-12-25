class ConfigurationsController < ApplicationController
  def create
    send_file Rails.root.join('spec/fixtures/configuration.zip')
  end
end
