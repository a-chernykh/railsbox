RSpec.describe ArchiveBuilder do
  describe '#build' do
    def stub_temp_dir(dir)
      allow(Dir).to receive(:mktmpdir) do
        dir
      end
    end

    def stub_archiver
      allow(Archiver).to receive(:new) { archiver }
    end

    let(:configurator) { double('BoxConfigurator').as_null_object }
    let(:archiver) { double('Archiver').as_null_object }
    subject { described_class.new(configurator) }

    let(:temp_dir) { Dir.mktmpdir }

    before { stub_temp_dir(temp_dir) }
    before { stub_archiver }

    it 'creates temp directory' do
      expect(Dir).to receive(:mktmpdir).and_call_original
      subject.build
    end

    it 'creates railsbox directory in temp directory' do
      allow(FileUtils).to receive(:remove_entry_secure)
      subject.build
      expect(File).to be_directory(File.join(temp_dir, 'railsbox'))
    end

    it 'saves configuration' do
      expect(configurator).to receive(:save).with(File.join(temp_dir, 'railsbox'))
      subject.build
    end

    it 'archives directory' do
      allow(Archiver).to receive(:new).with(temp_dir) { archiver }
      expect(archiver).to receive(:archive)
      subject.build
    end

    it 'removes temp directory' do
      expect(FileUtils).to receive(:remove_entry_secure).with(temp_dir)
      subject.build
    end
  end
end
