RSpec.describe DefaultConfiguration do
  describe '.get' do
    subject { described_class.get }

    it 'has 1024Mb RAM' do
      expect(subject[:development][:vm_memory]).to eq '1024'
    end

    it 'has myapp name' do
      expect(subject[:vm_name]).to eq 'myapp'
    end

    context 'by platform' do
      context 'windows' do
        it 'defaults to nfs share type' do
          expect(described_class.get(:mac)[:development][:vm_share_type]).to eq 'nfs'
        end
      end

      context 'windows' do
        it 'defaults to smb share type' do
          expect(described_class.get(:windows)[:development][:vm_share_type]).to eq 'smb'
        end
      end
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
      expect(subject[:development][:vm_ports]).to eq({})
    end
  end
end
