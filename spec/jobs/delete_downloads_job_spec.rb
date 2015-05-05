RSpec.describe DeleteDownloadsJob do
  describe '#perform' do
    it 'deletes all zip files in tmp/' do
      path = Rails.root.join('tmp/*.zip')
      allow(Dir).to receive(:[]).with(path).and_return ['file1.zip', 'file2.zip']
      expect(FileUtils).to receive(:rm).with ['file1.zip', 'file2.zip']
      described_class.perform_now(path)
    end
  end
end
