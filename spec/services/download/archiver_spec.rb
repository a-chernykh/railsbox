RSpec.describe Services::Download::Archiver do
  describe '#archive' do
    let(:zip) { Rails.root.join('tmp/test.zip') }

    before { FileUtils.rm_f zip }

    it 'creates zip archive' do
      described_class.new(Rails.root.join('templates')).archive(zip)
      expect(File).to exist(zip), "expected #{zip} to exists"
    end
  end
end
