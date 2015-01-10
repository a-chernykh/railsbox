require 'rails_helper'

describe ArchiveBuilder do
  describe '#build' do
    include FakeFS::SpecHelpers

    def stub_temp_dir(dir)
      allow(Dir).to receive(:mktmpdir) do
        Dir.mkdir dir
        dir
      end
    end

    def stub_archiver
      allow(Archiver).to receive(:new) { archiver }
    end

    let(:configurator) { double('BoxConfigurator').as_null_object }
    let(:archiver) { double('Archiver').as_null_object }
    subject { described_class.new(configurator) }

    before { stub_temp_dir('/tmp') }
    before { stub_archiver }

    it 'creates temp directory' do
      expect(Dir).to receive(:mktmpdir).and_call_original
      subject.build
    end

    it 'creates railsbox directory in temp directory' do
      expect(FileUtils).to receive(:remove_entry_secure)
      subject.build
      expect(File).to be_directory('/tmp/railsbox')
    end

    it 'saves configuration' do
      expect(configurator).to receive(:save).with('/tmp/railsbox')
      subject.build
    end

    it 'archives directory' do
      allow(Archiver).to receive(:new).with('/tmp') { archiver }
      expect(archiver).to receive(:archive)
      subject.build
    end

    it 'removes temp directory' do
      expect(FileUtils).to receive(:remove_entry_secure).with('/tmp')
      subject.build
    end
  end
end
