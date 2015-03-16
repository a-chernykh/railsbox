RSpec.describe Services::GemfileToConfiguration do
  let(:gemfile) { Tempfile.new('Gemfile') }
  let(:parser) { instance_double('Gemfile::Parser', gems: %w(rails pg), ruby_version: '1.9.3') }
  let(:builder) { instance_double('Gemfile::Builder').as_null_object }

  subject { described_class.new(gemfile) }

  describe '#call' do
    before do
      allow(Gemfile::Parser).to receive(:new).and_return parser
      allow(Gemfile::ConfigurationBuilder).to receive(:new).and_return builder
    end

    context 'when Gemfile is valid' do
      it 'parses Gemfile' do
        expect(Gemfile::Parser).to receive(:new).with(gemfile).and_call_original
        subject.call
      end

      it 'creates ConfigurationBuilder' do
        expect(Gemfile::ConfigurationBuilder).to receive(:new).with(DefaultConfiguration.get).and_call_original
        subject.call
      end

      it 'sets ruby version' do
        expect(builder).to receive(:set_ruby_version).with('1.9.3')

        subject.call
      end

      it 'adds gems' do
        expect(builder).to receive(:add_gem).with('rails')
        expect(builder).to receive(:add_gem).with('pg')

        subject.call
      end

      it 'returns success' do
        expect(subject.call).to be_success
      end

      it 'returns configuration' do
        allow(builder).to receive(:get).and_return 'configuration'
        expect(subject.call.data).to eq 'configuration'
      end
    end

    context 'when Gemfile is invalid' do
      it 'is failure' do
        allow(parser).to receive(:gems).and_raise(Parser::SyntaxError.new(double(message: 'whatever')))
        expect(subject.call).not_to be_success
      end
    end
  end
end
