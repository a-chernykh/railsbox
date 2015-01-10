require 'rails_helper'

describe 'boxes/show.html.slim' do
  describe 'by operating system' do
    let(:box) { stub_model(Box, secure_id: 'whatever') }

    before do
      assign :box, box
      allow(view).to receive(:browser) { double(platform: os) }
    end

    context 'mac' do
      let(:os) { :mac }

      it 'renders brew-cask requirements' do
        render
        expect(rendered).to include 'brew install caskroom/cask/brew-cask'
      end
    end

    context 'linux' do
      let(:os) { :linux }

      it 'renders apt-get requirements' do
        render
        expect(rendered).to include 'apt-get install'
      end
    end

    context 'windows' do
      let(:os) { :windows }

      it 'renders Windows requirements' do
        render
        expect(rendered).to include 'is not supported'
      end
    end

    context 'other' do
      let(:os) { :other }

      it 'renders other requirements' do
        render
        expect(rendered).to include 'You will need'
      end
    end
  end
end
