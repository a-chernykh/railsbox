describe TemplateContext do
  let(:server_type) { 'nginx_unicorn' }
  let(:context) { described_class.new({databases: %w(postgresql), background_jobs: %w(sidekiq), server_type: server_type}) }

  describe '#roles' do
    subject { context.roles }

    it { should     include 'postgresql' }
    it { should     include 'sidekiq' }
    it { should_not include 'mysql' }
  end

  describe '#server_role' do
    subject { context.server_role }

    context 'server_type == nginx_unicorn' do
      let(:server_type) { 'nginx_unicorn' }

      it { should eq 'unicorn' }
    end
    
    context 'server_type == nginx_puma' do
      let(:server_type) { 'nginx_puma' }

      it { should eq 'puma' }
    end

    context 'server_type == nginx_passenger' do
      let(:server_type) { 'nginx_passenger' }

      it { should eq 'passenger' }
    end
  end

  describe '#render' do
    subject(:rendered) { context.render 'vagrant_plugins' }

    it 'renders given partial' do
      expect(rendered).to include 'require_plugins'
    end
  end
end
