RSpec.describe Typecaster do
  describe '#typecasted' do
    it 'converts strings to boolean' do
      typecasted = described_class.new({'true' => 'true',
        'false' => 'false',
        'other' => 1,
        'arr' => ['a', 'b', 'c']}).typecasted
      expect(typecasted).to eq({'true' => true,
        'false' => false,
        'other' => 1,
        'arr' => ['a', 'b', 'c']})
    end

    it 'works with nested hashes' do
      typecasted = described_class.new({
        'nested' => {
          'true' => 'true',
          'false' => 'false',
          'other' => 1,
          'arr' => ['a', 'b', 'c']
        }
      }).typecasted
      expect(typecasted).to eq({
        'nested' => {
          'true' => true,
          'false' => false,
          'other' => 1,
          'arr' => ['a', 'b', 'c']
        }
      })
    end
  end
end
