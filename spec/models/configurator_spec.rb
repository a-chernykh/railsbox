require 'rails_helper'

describe Configurator do
  describe '#save' do
    let(:dir) { Dir.mktmpdir }

    subject(:configurator) { described_class.from_params(params_fixture) }

    before { configurator.save(dir) }

    it 'copies files without erb extensions' do
      expect(File).to exist(File.join(dir, '.gitignore'))
    end

    it 'creates Vagrantfile' do
      expect(File).to exist(File.join(dir, 'Vagrantfile'))
    end

    after { FileUtils.remove_entry_secure dir }
  end
end
