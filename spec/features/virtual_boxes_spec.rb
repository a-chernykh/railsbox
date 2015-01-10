require 'rails_helper'

feature 'Virtual boxes', js: true do
  scenario 'Create new box' do
    visit '/'
    fill_in 'Name', with: 'myapp'
    click_on I18n.t('boxes.form.create')
  
    expect(page).to have_selector(:link_or_button, I18n.t('boxes.show.download'))
  end

  scenario 'Download box' do
    visit '/'
    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.download')

    expect(page).not_to have_content 'Download'

    expect(page.response_headers['Content-Disposition']).to include 'attachment'

    files = zip_list_of_files(page.body)
    expect(files).to include('railsbox/Vagrantfile')
    expect(files).to include('railsbox/ansible/group_vars/all.yml')
  end

  scenario 'Edit box' do
    visit '/'

    uncheck I18n.t('boxes.form.autoconf')

    fill_in I18n.t('boxes.form.name'), with: 'myapp'
    fill_in I18n.t('boxes.form.memory'), with: '2048'

    click_on I18n.t('boxes.form.create')
    expect(page).to have_selector(:link_or_button, I18n.t('boxes.show.edit'))

    click_on I18n.t('boxes.show.edit')
    expect(find_field(I18n.t('boxes.form.memory')).value).to eq '2048'
  end
end
