RSpec.describe ConfigurationsController do
  describe 'POST for_gemfile' do
    let(:gemfile) { Tempfile.new('Gemfile') }

    before do
      gemfile.write gemfile_contents
      gemfile.close
    end

    context 'when valid Gemfile' do
      let(:gemfile_contents) do
        <<-EOS
  source 'https://rubygems.org'

  ruby '1.9.3'

  gem 'rails', '4.2'

  gem 'pg'
     EOS
      end

      it 'has 200 response code' do
        post :for_gemfile, gemfile: fixture_file_upload(gemfile.path)
        expect(response.code).to eq '200'
      end

      it 'returns configuration for Gemfile' do
        post :for_gemfile, gemfile: fixture_file_upload(gemfile.path)
        json = JSON.parse(response.body)
        expect(json['ruby_version']).to eq '1.9.3'
      end
    end

    context 'when Gemfile is invalid' do
      let(:gemfile_contents) { 'some weird non ruby 123 456' }

      it 'has 422 response code' do
        post :for_gemfile, gemfile: fixture_file_upload(gemfile.path)
        expect(response.code).to eq '422'
      end
    end

    after { gemfile.unlink }
  end
end
