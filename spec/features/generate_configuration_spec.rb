require 'rails_helper'

feature 'Create box', js: true do
  scenario 'User creates new box' do
    visit '/'
    fill_in 'Name', with: 'myapp'
    click_on I18n.t('dashboard.show.generate')
  
    expect(page).to have_selector(:link_or_button, I18n.t('boxes.show.download'))
  end

  scenario 'User downloads generated configuration' do
    visit '/'
    click_on I18n.t('dashboard.show.generate')
    click_on I18n.t('boxes.show.download')

    expect(page).not_to have_content 'Download'

    expect(page.response_headers['Content-Disposition']).to include 'attachment'

    files = zip_list_of_files(page.body)
    expect(files).to include('devops/Vagrantfile')
    expect(files).to include('devops/ansible/group_vars/all.yml')
  end
end
