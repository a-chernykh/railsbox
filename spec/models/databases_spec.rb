RSpec.describe Databases do
  describe '.list' do
    subject { described_class.list.map(&:id) }

    it { should include 'postgresql' }
  end

  describe '.port_for' do
    subject { described_class.port_for(db) }
    
    describe 'postgresql' do
      let(:db) { 'postgresql' }

      it { should eq 5432 }
    end

    describe 'mysql' do
      let(:db) { 'mysql' }

      it { should eq 3306 }
    end

    describe 'sidekiq' do
      let(:db) { 'sidekiq' }

      it { should eq nil }
    end
  end
end
