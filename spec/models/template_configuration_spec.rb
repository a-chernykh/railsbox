RSpec.describe TemplateConfiguration do
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
          expect(output).to include %Q(role: sidekiq)
        end
      end

      it 'does not copies files with .erb extension' do
        expect(File).not_to exist(File.join(dir, 'Vagrantfile.erb'))
      end

      it 'does not copies _vagrant_plugins partial' do
        expect(File).not_to exist(File.join(dir, '_vagrant_plugins'))
      end

      it 'does not copies _vagrant_plugins.erb partial' do
        expect(File).not_to exist(File.join(dir, '_vagrant_plugins.erb'))
      end

      after { FileUtils.remove_entry_secure dir }
    end
  end
end
