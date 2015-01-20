feature 'Provision boxes', js: true do
  def create_box(components)
    visit '/'

    components.each do |component|
      case component
      when 'rbenv'
        choose 'rbenv'
      when 'unicorn'
        choose 'nginx + unicorn'
      when 'postgresql'
        click_on I18n.t('boxes.form.add_database')
      end
    end

    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.download')

    expect(page).not_to have_content 'Download'
    expect(page.response_headers['Content-Disposition']).to include 'attachment'
  end

  scenario 'rbenv, unicorn, PostgreSQL, redis, sidekiq' do
    box = create_box %w(rbenv unicorn postgresql redis sidekiq)
  end
end
