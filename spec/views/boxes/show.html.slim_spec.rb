describe 'boxes/show.html.slim' do
  let(:box) { stub_model(Box, secure_id: 'whatever', vm_name: 'myapp') }
  let(:os)  { :mac }

  before do
    assign :box, BoxDecorator.decorate(box)
    allow(view).to receive(:browser) { double(platform: os) }
  end

  it 'has box http URL' do
    allow(box).to receive(:vm_ports).and_return({
      '0' => { 'guest' => 80, 'host' => 8080 },
      '1' => { 'guest' => 443, 'host' => 8081 },
    })
    render
    expect(rendered).to include 'http://localhost:8080'
  end

  describe 'by server type' do
    before { allow(box).to receive(:server_type).and_return server_type }

    context 'nginx and unicorn' do
      let(:server_type) { 'nginx_unicorn' }

      it 'includes unicorn control commands' do
        render
        expect(rendered).to include 'sudo start myapp'
      end
    end
    
    context 'nginx and puma' do
      let(:server_type) { 'nginx_puma' }

      it 'includes puma control commands' do
        render
        expect(rendered).to include 'sudo start myapp'
      end
    end

    context 'nginx and passenger' do
      let(:server_type) { 'nginx_passenger' }

      it 'includes passenger control commands' do
        render
        expect(rendered).to include 'touch tmp/restart.txt'
      end
    end
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
