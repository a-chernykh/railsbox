RSpec.describe TemplateContext do
  let(:server_type) { 'nginx_unicorn' }
  let(:context) do
    described_class.new(Rails.root.join('templates/environment/virtualbox/Vagrantfile.single.erb'),
                        {databases: %w(postgresql), background_jobs: %w(sidekiq), server_type: server_type})
  end

  describe '#roles' do
    subject { context.roles }

    it { is_expected.to     include 'postgresql' }
    it { is_expected.to     include 'sidekiq' }
    it { is_expected.not_to include 'mysql' }
  end

  describe '#server_role' do
    subject { context.server_role }

    context 'when server_type == nginx_unicorn' do
      let(:server_type) { 'nginx_unicorn' }

      it { is_expected.to eq 'unicorn' }
    end
    
    context 'when server_type == nginx_puma' do
      let(:server_type) { 'nginx_puma' }

      it { is_expected.to eq 'puma' }
    end

    context 'when server_type == nginx_passenger' do
      let(:server_type) { 'nginx_passenger' }

      it { is_expected.to eq 'passenger' }
    end
  end

  describe '#render' do
    subject(:rendered) { context.render 'vagrant_plugins' }

    it 'renders given partial' do
      expect(rendered).to include 'require_plugins'
    end
  end
end
