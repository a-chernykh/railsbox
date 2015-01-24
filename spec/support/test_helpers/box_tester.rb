module TestHelpers
  module BoxTester
    def download_box(*components)
      visit '/'

      # We don't want vagrant to ask root password (required by NFS)
      select 'VirtualBox', from: 'Share type'

      # Speed up
      uncheck 'curl'
      uncheck 'Graphics kit'
      uncheck 'QT kit'

      components.each do |component|
        case component
        when 'rbenv'
          choose 'rbenv'
        when 'rvm'
          choose 'RVM'
          select '2.1.5', from: 'Ruby version' # precompiled binaries available (faster)
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

      page.body
    end

    def test_box(zip_content, app)
      dir = nil
      success = false
      begin
        dir = extract_zip(zip_content)
        FileUtils.cp_r File.join(Rails.root.join('spec/fixtures', app), '.'), dir
        Dir.chdir("#{dir}/railsbox") do
          begin
            success = system({'ANSIBLE_ARGS' => '-e use_apt_proxy=true'}, 'vagrant up')
            print_left_notice(dir) unless success
            expect(success).to eq true

            # give unicorn / worker some time to start
            sleep(10)

            require 'open-uri'
            response = open('http://localhost:8080/').read
            expect(response).to eq 'ok'
          ensure
            system('vagrant destroy -f') if success
          end
        end
      ensure
        FileUtils.remove_entry_secure dir if success
      end
    end

    def print_left_notice(dir)
      puts <<-eos

vagrant is left at #{dir}, please run run this manually to destroy it:

cd #{dir}/railsbox
vagrant destroy -f
cd -
rm -rf #{dir}

eos
    end
  end
end
