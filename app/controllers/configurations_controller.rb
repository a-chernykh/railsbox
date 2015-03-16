class ConfigurationsController < ApplicationController
  def for_gemfile
    result = Services::GemfileToConfiguration.new(params[:gemfile]).call
    if result.success?
      render json: result.data
    else
      render json: result.data, status: 422
    end
  end
end
