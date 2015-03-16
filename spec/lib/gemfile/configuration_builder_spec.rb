RSpec.describe Gemfile::ConfigurationBuilder do
  let(:configuration) { DefaultConfiguration.get }
  let(:builder) { described_class.new(configuration) }

  subject { builder.get }

  describe '#set_ruby_version' do
    before { builder.set_ruby_version '2.1.0' }

    it 'updates ruby version' do
      expect(subject[:ruby_version]).to eq '2.1.0'
    end
  end

  describe '#add_gem' do
    before { builder.add_gem gem_name }

    describe 'rspec' do
      let(:gem_name) { 'rspec' }

      it 'does nothing' do
        expect(subject).to eq configuration
      end
    end

    describe 'capybara-webkit' do
      let(:gem_name) { 'capybara-webkit' }

      it 'adds qt5-default and libqt5webkit5-dev apt packages' do
        expect(subject[:packages]).to include('qt5-default', 'libqt5webkit5-dev')
      end
    end

    describe 'pg' do
      let(:gem_name) { 'pg' }

      it 'installs PostgreSQL' do
        expect(subject[:databases]).to include('postgresql')
      end
    end

    describe 'mysql' do
      let(:gem_name) { 'mysql' }

      it 'removes PostgreSQL' do
        expect(subject[:databases]).not_to include('postgresql')
      end

      it 'installs MySQL' do
        expect(subject[:databases]).to include('mysql')
      end
    end

    describe 'mysql2' do
      let(:gem_name) { 'mysql2' }

      it 'removes PostgreSQL' do
        expect(subject[:databases]).not_to include('postgresql')
      end

      it 'installs MySQL' do
        expect(subject[:databases]).to include('mysql')
      end
    end

    describe 'activerecord-postgis-adapter' do
      let(:gem_name) { 'activerecord-postgis-adapter' }

      it 'adds PostgreSQL' do
        expect(subject[:databases]).to include('postgresql')
      end

      it 'adds PostGIS extension' do
        expect(subject[:postgresql_extensions]).to include('postgis')
      end
    end

    describe 'nokogiri' do
      let(:gem_name) { 'nokogiri' }

      it 'installs packages' do
        expect(subject[:packages]).to include('zlib1g-dev')
      end
    end

    describe 'mini_magick' do
      let(:gem_name) { 'mini_magick' }

      it 'installs packages' do
        expect(subject[:packages]).to include('imagemagick')
      end
    end

    describe 'sidekiq' do
      let(:gem_name) { 'sidekiq' }

      it 'adds sidekiq' do
        expect(subject[:background_jobs]).to include('sidekiq')
      end
    end
  end
end
