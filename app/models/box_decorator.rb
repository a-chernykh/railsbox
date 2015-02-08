class BoxDecorator < SimpleDelegator
  def self.decorate(box)
    new(box)
  end

  def http_url
    port = find_by_guest_port(80)
    "http://localhost:#{port['host']}" if port
  end

  def https_url
    port = find_by_guest_port(443)
    "https://localhost:#{port['host']}" if port
  end

  def vm_shared_directory
    default_environment['vm_shared_directory']
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
