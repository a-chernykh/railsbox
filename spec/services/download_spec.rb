RSpec.describe Services::Download do
  let(:box) { Box.new }

  describe '#call' do
    let(:archive) { described_class.new(box).call }

    it 'sets path' do
      expect(archive.path).to be_present
    end

    it 'sets file name' do
      expect(archive.file_name).to be_present
    end

    it 'deletes old files' do
      expect(DeleteDownloadsJob).to receive(:perform_now)
        .with(Rails.root.join('tmp/*.zip').to_s)
      described_class.new(box).call
    end
  end
end
