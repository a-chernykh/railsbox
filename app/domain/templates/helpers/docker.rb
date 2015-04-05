module Templates
  module Helpers
    module Docker
      def docker_ports_for(role)
        port = Databases.port_for(role)
        if port
          [%Q('#{port}:#{port}')]
        else
          []
        end
      end
    end
  end
end
