require 'delegate'

module TestHelpers
  module Box
    class BoxTester
      def initialize(opts)
        @dir        = opts[:dir]
        @app        = opts[:app]
        @ansible    = opts[:ansible].nil? ? true : opts[:ansible]
        @target     = opts[:target] || 'virtualbox'
      end

      def test
        app_ok = false
        begin
          FileUtils.cp_r File.join(Rails.root.join('spec/fixtures', @app), '.'), @dir
          Dir.chdir("#{@dir}/railsbox/development") do
            begin
              env = {'ANSIBLE_ARGS' => '-e use_apt_proxy=true'}
              # a little hack to make ansible_installed? return false
              env['PATHEXT'] = 'whatever' unless @ansible
              is_provisioned = system(env, 'vagrant up')
              return false unless is_provisioned

              # give unicorn / worker some time to start
              sleep(10)

              require 'open-uri'
              app_ok = open('http://localhost:8080/').read == 'ok'

              app_ok
            ensure
              if app_ok
                system('vagrant destroy -f')
              else
                show_vagrant_leftover
              end
            end
          end
        ensure
          FileUtils.remove_entry_secure @dir if app_ok
        end
      end

      private

      def show_vagrant_leftover
        puts <<-eos.gsub /^\s+/, ""
          WARNING: vagrant is left at #{@dir}, please run this manually to destroy it:

          cd #{@dir}/railsbox/development
          vagrant destroy -f
          cd -
          rm -rf #{@dir}
        eos
      end
    end

    class BoxDownloader < SimpleDelegator
      def initialize(opts)
        @components = opts[:components]
        @target     = opts[:target] || 'virtualbox'

        __setobj__(opts[:context])
      end

      def zip_contents
        prepare

        click_on t('create')
        click_on I18n.t('boxes.show.download')

        expect(page).not_to have_content 'Download'
        expect(page.response_headers['Content-Disposition']).to include 'attachment'

        page.body
      end

      private

      def t(key)
        I18n.t("boxes.form.#{key}")
      end

      def prepare
        visit '/'

        if @target == 'virtualbox'
          # We don't want vagrant to ask root password (required by NFS)
          select t('virtualbox'), from: t('share_type')
        else
          choose t('remote_server')
          fill_in t('server_host'), with: 'localhost'
          fill_in t('server_port'), with: '2222'
          fill_in t('server_username'), with: 'vagrant'
        end

        # Speed up
        uncheck t('curl')
        uncheck t('graphics_kit')
        uncheck t('qt_kit')

        @components.each do |component|
          case component
          when 'rbenv'
            choose t('rbenv')
          when 'rvm'
            choose t('rvm')
            select '2.1.5', from: t('.ruby_version') # precompiled binaries available (faster)
          when 'system_package'
            choose t('system_package')
          when 'passenger', 'unicorn'
            choose t("nginx_#{component}")
          when 'postgresql'
            # Default, do nothing
          when 'mysql'
            # PostgreSQL is default, need to delete it
            page.find('.database', text: t('postgresql')).click_button 'Delete'

            click_on t('add_database')
            click_on t(component)
          when 'redis'
            click_on t('add_database')
            click_on t(component)
          when 'sidekiq', 'delayed_job'
            click_on t('add_worker')
            click_on t(component)
          end
        end
      end
    end

    def test_box(opts)
      zip = BoxDownloader.new(opts.merge(context: self)).zip_contents
      dir = extract_zip(zip)
      result = BoxTester.new(opts.merge(dir: dir)).test
      expect(result).to eq true
    end
  end
end
