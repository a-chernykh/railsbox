module TemplateHelpers
  module Roles
    def roles
      params[:databases] + params[:background_jobs]
    end

    def server_role
      params[:server_type].sub 'nginx_', ''
    end
  end  
end
