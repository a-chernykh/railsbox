require 'rails_helper'

feature 'Generate configuration', js: true do
  scenario 'User generates new configuration' do
    visit '/'
    click_button I18n.t('dashboard.show.generate')

    expect(page).not_to have_css('[name=vm_name]') # a little hack to wait for the page load

    expect(page.response_headers['Content-Disposition']).to include 'attachment'

    files = zip_list_of_files(page.body)
    expect(files).to include('devops/Vagrantfile')
    expect(files).to include('devops/ansible/group_vars/all.yml')
  end
end
