RSpec.describe VersionManager do
  describe '#current_version' do
    it 'extracts version from the commit tag' do
      allow(subject).to receive(:git_tags).and_return(['v1.0'])
      expect(subject.current_version).to eq '1.0'
    end

    it 'returns nil when no tags' do
      allow(subject).to receive(:git_tags).and_return([])
      expect(subject.current_version).to be_nil
    end
  end
end
