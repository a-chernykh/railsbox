describe TemplateConfiguration do
  describe '#save' do
    let(:dir)    { Dir.mktmpdir }
    let(:params) { params_fixture }

    before { CopyConfiguration.new(params).save(dir) }

    describe 'files' do
      subject(:output) { IO.read(File.join(dir, file)) }

      before { described_class.new(params).save(dir) }

      context 'ansible/group_vars/all/config.yml' do
        let(:file) { self.class.description }

        it 'sets server_name' do
          expect(output).to include %Q(server_name: localhost)
        end
      end

      context 'ansible/site.yml' do
        let(:file) { self.class.description }

        it 'includes postgresql role' do
          expect(output).to include %Q(- postgresql)
        end

        it 'includes sidekiq role' do
          expect(output).to include %Q(- sidekiq)
        end
      end

      it 'does not copies files with .erb extension' do
        expect(File).not_to exist(File.join(dir, 'Vagrantfile.erb'))
      end

      it 'does not copies partials' do
        expect(File).not_to exist(File.join(dir, '_vagrant_plugins'))
        expect(File).not_to exist(File.join(dir, '_vagrant_plugins.erb'))
      end

      context 'Vagrantfile' do
        let(:file) { self.class.description }

        it 'sets name' do
          expect(output).to include %Q(config.vm.define 'testapp')
          expect(output).to include %Q(hostname = 'localhost')
        end

        it 'sets operating system' do
          expect(output).to include %Q(config.vm.box = 'ubuntu/trusty64')
        end

        it 'sets memory' do
          expect(output).to include %Q(.memory = 1024)
        end

        it 'sets cores' do
          expect(output).to include %Q(.cpus = 2)
        end

        it 'sets forwarded port' do
          expect(output).to include %Q(vm.network 'forwarded_port', :guest => 80, :host => 8080)
        end
      end

      after { FileUtils.remove_entry_secure dir }
    end
  end
end
