describe 'boxes/show.html.slim' do
  let(:box) { stub_model(Box, secure_id: 'whatever') }
  let(:os)  { :mac }

  before do
    assign :box, BoxDecorator.decorate(box)
    allow(view).to receive(:browser) { double(platform: os) }
  end

  it 'has box http URL' do
  end

  describe 'by operating system' do
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
