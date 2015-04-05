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
  end
end
