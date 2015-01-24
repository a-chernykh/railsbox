describe Box do
  it { should validate_presence_of(:params) }
  it { should_not allow_value('<test').for(:vm_name) }
  it { should allow_value('my_app').for(:vm_name) }
  it { should allow_value('my-app').for(:vm_name) }

  describe 'secure_id' do
    let(:params) { { params: {databases: []} } }

    before { allow(SecureIdGenerator).to receive(:generate) { '123' } }

    it 'generates unique secure id' do
      box = described_class.create!(params)
      expect(box.secure_id).to eql '123'
    end

    it 'checks the uniqueness of secure id' do
      allow(described_class).to receive(:exists?).with({secure_id: '123'})
      described_class.create!(params)
    end
  end

  describe '#to_param' do
    it 'returns secure_id' do
      box = Box.new secure_id: 'abc123'
      expect(box.to_param).to eq 'abc123'
    end
  end

  describe '#vm_name' do
    it 'will extract name from params' do
      box = Box.new params: { vm_name: 'myapp' }
      expect(box.vm_name).to eq 'myapp'
    end
  end

  describe '.background_jobs' do
    subject { described_class.background_jobs.map(&:id) }

    it { should include 'sidekiq' }
  end
end
