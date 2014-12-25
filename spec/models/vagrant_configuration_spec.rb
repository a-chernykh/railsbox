require 'rails_helper'

describe VagrantConfiguration do
  describe '#save' do
    let(:dir) { Dir.mktmpdir }
    let(:configuration) do
      { name: 'myapp',
        os: 'ubuntu/trusty64',
        memory: 700,
        cores: 2,
        forwarded_port: 8080 }
    end

    subject(:output) { IO.read(File.join(dir, 'Vagrantfile')) }

    before { described_class.new(configuration).save(dir) }

    it 'sets name' do
      expect(output).to include %Q(config.vm.define 'myapp')
      expect(output).to include %Q(hostname = 'myapp')
    end

    it 'sets operating system' do
      expect(output).to include %Q(config.vm.box = 'ubuntu/trusty64')
    end

    it 'sets memory' do
      expect(output).to include %Q(.memory = 700)
    end

    it 'sets cores' do
      expect(output).to include %Q(.cpus = 2)
    end

    it 'sets forwarded port' do
      expect(output).to include %Q(vm.network 'forwarded_port', guest: 80, host: 8080)
    end

    after { FileUtils.remove_entry_secure dir }
  end
end
