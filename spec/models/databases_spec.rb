RSpec.describe Databases do
  describe '.list' do
    subject { described_class.list.map(&:id) }

    it { is_expected.to include 'postgresql' }
  end

  describe '.port_for' do
    subject { described_class.port_for(db) }
    
    describe 'postgresql' do
      let(:db) { 'postgresql' }

      it { is_expected.to eq 5432 }
    end

    describe 'mysql' do
      let(:db) { 'mysql' }

      it { is_expected.to eq 3306 }
    end

    describe 'sidekiq' do
      let(:db) { 'sidekiq' }

      it { is_expected.to eq nil }
    end
  end
end
