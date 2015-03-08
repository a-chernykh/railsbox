describe EnvironmentsConfiguration do
  describe '#save' do
    let(:params) do
      params_fixture.merge(environments: %w(development staging), staging: {
        'target': 'server',
        'host': 'myapp.com',
        'port': '22',
        'username': 'ubuntu',
      })
    end
    let(:staging_inventory_path) { File.join(@dir, 'staging', 'inventory') }
    let(:staging_provision_path) { File.join(@dir, 'staging', 'provision.sh') }
    subject { described_class.new(params) }

    before { @dir = Dir.mktmpdir }
    before { CopyConfiguration.new(params).save(@dir) }
    before { subject.save(@dir) }

    it 'creates development directory' do
      expect(Dir).to exist(File.join(@dir, 'development'))
    end

    it 'creates staging directory' do
      expect(Dir).to exist(File.join(@dir, 'staging'))
    end

    it 'does not creates production directory' do
      expect(Dir).not_to exist(File.join(@dir, 'production'))
    end

    describe 'development - VirtualBox' do
      let(:vagrantfile_path) { File.join(@dir, 'development', 'Vagrantfile') }
      let(:config_path) { File.join(@dir, 'ansible/group_vars/development/config.yml') }

      it 'copies Vagrantfile' do
        expect(File).to exist(vagrantfile_path)
      end

      it 'does not creates development/inventory' do
        expect(File).not_to exist(File.join(@dir, 'development', 'inventory'))
      end

      it 'does not creates development/provision.sh' do
        expect(File).not_to exist(File.join(@dir, 'development', 'provision.sh'))
      end

      context 'ansible/group_vars/development/config.yml' do
        let(:output) { IO.read(config_path) }

        it 'sets rails_env' do
          expect(output).to include %Q(rails_env: development)
        end
      end

      context 'Vagrantfile' do
        let(:output) { IO.read(vagrantfile_path) }

        it 'sets name' do
          expect(output).to include %Q(.vm.define 'testapp')
          expect(output).to include %Q(hostname = 'localhost')
        end

        it 'sets operating system' do
          expect(output).to include %Q(.vm.box = 'ubuntu/trusty64')
        end

        it 'sets memory' do
          expect(output).to include %Q(sysctl -n hw.memsize)
        end

        it 'sets cores' do
          expect(output).to include %Q(sysctl -n hw.ncpu)
        end

        it 'sets forwarded port' do
          expect(output).to include %Q(vm.network 'forwarded_port', :guest => 80, :host => 8080)
        end

        it 'sets box ip' do
          expect(output).to include %Q(.vm.network 'private_network', ip: '192.168.20.50')
        end
      end
    end

    describe 'staging - remote server' do
      it 'creates staging/inventory' do
        expect(File).to exist(staging_inventory_path)
      end

      it 'creates staging/provision.sh' do
        expect(File).to exist(staging_provision_path)
      end

      it 'keeps executable flag on staging/provision.sh' do
        expect(File).to be_executable(staging_provision_path)
      end
    end

    after { FileUtils.remove_entry_secure @dir }
  end
end
