RSpec.describe SecureIdGenerator do
  describe '.generate' do
    it 'returns unique strings' do
      id1 = described_class.generate
      id2 = described_class.generate
      id3 = described_class.generate

      ids = [id1, id2, id3]

      expect(ids.uniq.length).to eq(3), "expected #{ids} to be unique"
    end

    it 'returns fixed length string' do
      expect(described_class.generate.length).to eq 12
    end

    it 'only contains alphanumeric chars' do
      expect(described_class.generate).to match /^[a-z0-9]+$/
    end
  end
end
