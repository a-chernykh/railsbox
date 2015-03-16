require 'stringio'

RSpec.describe Gemfile::Parser do
  let(:gemfile) do
    <<-EOS
source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2'

gem 'pg'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
end

group :development do
  gem 'rspec'
end
    EOS
  end

  subject(:parser) { described_class.new(StringIO.new(gemfile)) }

  describe '#gems' do
    subject { parser.gems }

    it { is_expected.to eq ['rails', 'pg', 'rails-assets-angular', 'rspec'] }
  end

  describe '#ruby_version' do
    subject { parser.ruby_version }

    it { is_expected.to eq '2.2.0' }
  end
end
