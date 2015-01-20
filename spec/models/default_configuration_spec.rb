describe DefaultConfiguration do
  describe '.get' do
    subject { described_class.get }

    it 'has 1024Mb RAM' do
      expect(subject[:vm_memory]).to eq '1024'
    end

    it 'has myapp name' do
      expect(subject[:vm_name]).to eq 'myapp'
    end
  end

  describe '.base' do
    subject { described_class.base }

    it 'has empty list of databases' do
      expect(subject[:databases]).to eq []
    end

    it 'has empty list of background jobs' do
      expect(subject[:background_jobs]).to eq []
    end

    it 'has empty list of packages' do
      expect(subject[:packages]).to eq []
    end

    it 'has empty list of forwarded ports' do
      expect(subject[:vm_ports]).to eq({})
    end
  end
end
