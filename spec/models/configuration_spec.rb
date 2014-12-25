require 'rails_helper'

describe Configuration do
  describe '#save' do
    let(:vm) do
      { name: 'myapp',
        os: 'ubuntu/trusty64',
        memory: 700,
        cores: 2,
        forwarded_port: 8080 }
    end
    let(:params) do
      { vm: vm }
    end
    let(:dir) { Dir.mktmpdir }
    let(:configurators) do
      [ CopyConfiguration.new,
        VagrantConfiguration.new(params[:vm]) ]
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
