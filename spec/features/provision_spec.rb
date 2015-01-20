feature 'Provision boxes', js: true do
  def create_box(components)
    visit '/'

    # We don't want vagrant to ask root password (required by NFS)
    select 'VirtualBox', from: 'Share type'

    components.each do |component|
      case component
      when 'rbenv'
        choose 'rbenv'
      when 'unicorn'
        choose 'nginx + unicorn'
      when 'postgresql'
        # Default, do nothing
      when 'redis'
        click_on I18n.t('boxes.form.add_database')
        click_on 'Redis'
      when 'sidekiq'
        click_on I18n.t('boxes.form.add_worker')
        click_on 'sidekiq'
      end
    end

    click_on I18n.t('boxes.form.create')
    click_on I18n.t('boxes.show.download')

    expect(page).not_to have_content 'Download'
    expect(page.response_headers['Content-Disposition']).to include 'attachment'
  end

  def test(app)
    dir = nil
    begin
      dir = extract_zip(page.body)
      FileUtils.cp_r File.join(Rails.root.join('spec/fixtures', app), '.'), dir
      Dir.chdir("#{dir}/railsbox") do
        begin
          rc = system('vagrant up')
          expect(rc).to eq true
        ensure
          system('vagrant destroy -f')
        end
      end
    ensure
      FileUtils.remove_entry_secure dir
    end
  end

  scenario 'rbenv, unicorn, PostgreSQL, redis, sidekiq' do
    create_box %w(rbenv unicorn postgresql redis sidekiq)
    test('testapp1')
  end
end
