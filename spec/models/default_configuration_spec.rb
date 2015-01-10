describe DefaultConfiguration do
  describe '#get' do
    subject { described_class.new.get }

    it 'has 1024Mb RAM' do
      expect(subject[:vm_memory]).to eq '1024'
    end

    it 'has myapp name' do
      expect(subject[:vm_name]).to eq 'myapp'
    end
  end
end
