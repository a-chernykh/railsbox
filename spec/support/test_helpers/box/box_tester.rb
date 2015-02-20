require 'open-uri'

module TestHelpers
  module Box

    class BoxTester
      def initialize(opts)
        @dir     = opts[:dir]
        @app     = opts[:app]
        @ansible = opts[:ansible].nil? ? true : opts[:ansible]
        @target  = opts[:target] || 'virtualbox'
      end

      def test
        begin
          FileUtils.cp_r File.join(Rails.root.join('spec/fixtures', @app), '.'), @dir

          is_provisioned = vagrant.up
          return false unless is_provisioned

          # give unicorn / worker some time to start
          sleep(10)

          success = smoke_passed?
          vagrant.destroy if success

          success
        ensure
          show_vagrant_leftover unless vagrant.destroyed?
        end
      end

      private

      def vagrant_dir
        "#{@dir}/railsbox/development"
      end

      def vagrant
        @vagrant ||= VagrantDriver.new(dir: vagrant_dir, env: env)
      end

      def smoke_passed?
        open('http://localhost:8080/').read == 'ok'
      end

      def env
        env = {'ANSIBLE_ARGS' => '-e use_apt_proxy=true'}
        # a little hack to make ansible_installed? return false
        env['PATHEXT'] = 'whatever' unless @ansible
        env
      end

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

  end
end
