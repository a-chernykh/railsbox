describe 'dashboard/show.html.slim' do
  REQUIRED_PARAMS = %w(vm_name vm_os vm_memory vm_cores server_name postgresql_db_name postgresql_db_user ruby_install ruby_version)

  REQUIRED_PARAMS.each do |param|
    it "includes #{param} input" do
      render
      expect(rendered).to have_css("[name='box[#{param}]']")
    end
  end
end
