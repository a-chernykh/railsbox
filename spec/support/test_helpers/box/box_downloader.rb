require 'delegate'

module TestHelpers
  module Box

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

        fill_in t('name'), with: 'testapp'
        fill_in t('git_url'), with: 'git@github.com:andreychernih/railsbox-testapp.git'

        if @target == 'virtualbox'
          # We don't want vagrant to ask root password (required by NFS)
          select t('virtualbox'), from: t('share_type')
        else
          choose t('remote_server')
          
          fill_in t('server_host'), with: 'localhost'
          fill_in t('server_port'), with: '2299' # see spec/fixtures/Vagrantfile
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

  end
end
