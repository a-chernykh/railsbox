describe BoxConfigurator do
  subject(:configurator) { described_class.from_params(params_fixture) }

  describe '#save' do
    let(:dir) { Dir.mktmpdir }

    before { configurator.save(dir) }

    it 'copies files without erb extensions' do
      expect(File).to exist(File.join(dir, '.gitignore'))
    end

    it 'creates Vagrantfile' do
      expect(File).to exist(File.join(dir, 'development/Vagrantfile'))
    end

    after { FileUtils.remove_entry_secure dir }
  end

  describe '#file_name' do
    its(:file_name) { should eq 'testapp-railsbox.zip' }

    it 'only allows chars, digits, dash and underscore' do
      configurator = described_class.from_params(params_fixture.merge(vm_name: '../my-app123)('))
      expect(configurator.file_name).to eq 'my-app123-railsbox.zip'
    end
  end
end
