require 'rails_helper'

describe Configuration do
  describe '#save' do
    let(:params) do
      { vm_name: 'myapp',
        vm_os: 'ubuntu/trusty64',
        vm_memory: 700,
        vm_cores: 2,
        vm_forwarded_port: 8080,
        server_name: 'localhost',
        ruby_version: '2.1.2',
        database_name: 'myapp',
        database_user: 'myapp' }
    end
    let(:dir) { Dir.mktmpdir }
    let(:configurators) do
      [ CopyConfiguration.new,
        TemplateConfiguration.new(params) ]
    end

    subject(:configuration) { described_class.new(configurators) }

    before { configuration.save(dir) }

    it 'copies files without erb extensions' do
      expect(File).to exist(File.join(dir, '.gitignore'))
    end

    it 'creates Vagrantfile' do
      expect(File).to exist(File.join(dir, 'Vagrantfile'))
    end

    after { FileUtils.remove_entry_secure dir }
  end
end
