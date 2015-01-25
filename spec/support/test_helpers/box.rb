module TestHelpers
  module Box
    class BoxTester
      def initialize(opts)
        @app        = opts[:app]
        @components = opts[:components]
        @context    = opts[:context]
      end

      def test
        dir = nil
        app_ok = false
        begin
          dir = @context.extract_zip(download)
          FileUtils.cp_r File.join(Rails.root.join('spec/fixtures', @app), '.'), dir
          Dir.chdir("#{dir}/railsbox") do
            begin
              is_provisioned = system({'ANSIBLE_ARGS' => '-e use_apt_proxy=true'}, 'vagrant up')
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
                show_vagrant_leftover(dir)
              end
            end
          end
        ensure
          FileUtils.remove_entry_secure dir if app_ok
        end
      end

      private

      def download
        components = @components

        @context.instance_eval do
          def t(key)
            I18n.t("boxes.form.#{key}")
          end

          visit '/'

          # We don't want vagrant to ask root password (required by NFS)
          select t('virtualbox'), from: t('share_type')

          # Speed up
          uncheck t('curl')
          uncheck t('graphics_kit')
          uncheck t('qt_kit')

          components.each do |component|
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
            when 'mysql', 'redis'
              click_on t('add_database')
              click_on t(component)
            when 'sidekiq', 'delayed_job'
              click_on t('add_worker')
              click_on t(component)
            end
          end

          click_on t('create')
          click_on I18n.t('boxes.show.download')

          expect(page).not_to have_content 'Download'
          expect(page.response_headers['Content-Disposition']).to include 'attachment'

          page.body
        end
      end

      def show_vagrant_leftover(dir)
        puts <<-eos.gsub /^\s+/, ""
          WARNING: vagrant is left at #{dir}, please run this manually to destroy it:

          cd #{dir}/railsbox
          vagrant destroy -f
          cd -
          rm -rf #{dir}
        eos
      end
    end

    def test_box(opts)
      result = BoxTester.new(opts.merge(context: self)).test
      expect(result).to eq true
    end
  end
end
