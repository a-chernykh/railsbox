RSpec.feature 'Virtual boxes', js: true do
  def wait_for_download
    # workaround for https://github.com/thoughtbot/capybara-webkit/issues/319
    page.document.synchronize(2) do
      raise Capybara::ElementNotFound unless page.response_headers['Content-Type'] =~ /zip/
    end
  end

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

    wait_for_download

    files = zip_list_of_files(page.body)
    expect(files).to include('railsbox/development/Vagrantfile',
                             'railsbox/ansible/group_vars/all/config.yml',
                             'railsbox/ansible/roles/postgresql/tasks/main.yml')
  end

  scenario 'Add MongoDB with custom name' do
    visit '/'

    click_on I18n.t('boxes.form.add_database')
    click_on I18n.t('boxes.form.mongodb')
    page.find('.database', text: I18n.t('boxes.form.mongodb')).fill_in I18n.t('boxes.form.database_name'), with: 'mymongo'

    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.edit')

    mongo_section = page.find('.database', text: I18n.t('boxes.form.mongodb'))

    expect(mongo_section.find_field(I18n.t('boxes.form.database_name')).value).to eq 'mymongo'
  end

  scenario 'Edit name' do
    visit '/'

    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.edit')

    fill_in 'Name', with: 'anotherapp'

    click_on I18n.t('boxes.form.edit')

    expect(page).to have_content(I18n.t('boxes.show.title') + ' anotherapp')
  end

  scenario 'Delete box' do
    visit '/'

    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.delete')

    expect(page).to have_content(I18n.t('deleted'))
    expect(Box.count).to eq 0
  end
end
