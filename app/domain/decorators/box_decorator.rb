module Decorators
  class BoxDecorator < SimpleDelegator
    def self.decorate(box)
      new(box)
    end

    def http_url
      if params["development"]["use_hostname"]
        "http://#{vm_name}.dev"
      else
        port = find_by_guest_port(80)
        "http://localhost:#{port['host']}" if port
      end
    end

    def https_url
      if params["development"]["use_hostname"]
        "https://#{vm_name}.dev"
      else
        port = find_by_guest_port(443)
        "https://localhost:#{port['host']}" if port
      end
    end

    private

    def default_environment
      %w(development production staging).map { |e| send(e) }.compact.first
    end

    def vm_ports
      default_environment['vm_ports']
    end

    def find_by_guest_port(port_number)
      (vm_ports || {}).values.find { |port| port['guest'].try(:to_s) == port_number.to_s }
    end
  end
end
