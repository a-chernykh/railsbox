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

          copy_dummy_vagrantfile if remote_server?

          is_provisioned = vagrant.up
          return false unless is_provisioned

          if remote_server?
            env = { 'ANSIBLE_HOST_KEY_CHECKING' => 'false' }
            CommandRunner.run(
              cmd: './provision.sh --private-key .vagrant/machines/ubuntu/virtualbox/private_key', 
              env: env,
              dir: vagrant_dir
            )
            CommandRunner.run(
              cmd: './deploy.sh --private-key .vagrant/machines/ubuntu/virtualbox/private_key',
              env: env, 
              dir: vagrant_dir
            )
          end

          # give server / worker some time to start
          sleep(10)

          success = smoke_passed?
          vagrant.destroy if success

          success
        ensure
          show_vagrant_leftover unless vagrant.destroyed?
        end
      end

      private

      def remote_server?
        @target == 'server'
      end

      def copy_dummy_vagrantfile
        FileUtils.cp Rails.root.join('spec/fixtures/Vagrantfile'), vagrant_dir
      end

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
        command = <<-eos
cd #{@dir}/railsbox/development
vagrant destroy -f
cd -
rm -rf #{@dir}
        eos

        File.open('cleanup.sh', 'w') do |f|
          f.write "#/bin/bash\n"
          f.write "set -e\n"
          f.write command
          f.chmod 0777
        end

        puts "WARNING: vagrant is left at #{@dir}, please run ./cleanup.sh to destroy it"
      end
    end

  end
end
