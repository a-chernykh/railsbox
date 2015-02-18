feature 'Virtual boxes', js: true do
  scenario 'Create new box redirects to download page' do
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
    expect(files).to include('railsbox/development/Vagrantfile')
    expect(files).to include('railsbox/ansible/group_vars/all/config.yml')
    expect(files).to include('railsbox/ansible/roles/postgresql/tasks/main.yml')
    expect(files).not_to include('railsbox/ansible/roles/mongodb/tasks/main.yml')
  end

  scenario 'Edit box' do
    visit '/'

    uncheck I18n.t('boxes.form.autoconf')

    fill_in I18n.t('boxes.form.name'), with: 'myapp'
    fill_in I18n.t('boxes.form.memory'), with: '2048'

    click_on I18n.t('boxes.form.add_database')
    click_on I18n.t('boxes.form.mongodb')
    page.find('.database', text: I18n.t('boxes.form.mongodb')).fill_in I18n.t('boxes.form.database_name'), with: 'mymongo'

    click_on I18n.t('boxes.form.create')
    expect(page).to have_selector(:link_or_button, I18n.t('boxes.show.edit'))

    click_on I18n.t('boxes.show.edit')
    expect(find_field(I18n.t('boxes.form.memory')).value).to eq '2048'
    expect(page.find('.database', text: I18n.t('boxes.form.mongodb')).find_field(I18n.t('boxes.form.database_name')).value).to eq 'mymongo'
  end
end
