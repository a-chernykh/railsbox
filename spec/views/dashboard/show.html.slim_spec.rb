require 'rails_helper'

describe 'dashboard/show.html.slim' do
  REQUIRED_PARAMS = %w(vm_name vm_os vm_memory vm_cores vm_forwarded_port server_name ruby_version database_name database_user)

  REQUIRED_PARAMS.each do |param|
    it "includes #{param} input" do
      render
      expect(rendered).to have_css("[name=#{param}]")
    end
  end
end
