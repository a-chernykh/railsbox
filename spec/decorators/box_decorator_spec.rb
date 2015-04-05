RSpec.describe Decorators::BoxDecorator do
  let(:params) { params_fixture }
  let(:box) { stub_model(Box, secure_id: 'whatever', params: params) }

  subject(:decorated) { described_class.decorate(box) }

  describe '#vm_name' do
    it 'passes through' do
      expect(decorated.vm_name).to eq 'testapp'
    end
  end

  describe '#http_url' do
    context 'when 80 port exists' do
      it 'returns http://localhost:8080' do
        allow(decorated).to receive(:vm_ports).and_return({"0"=>{"guest"=>"80", "host"=>"8080"}})
        expect(decorated.http_url).to eq 'http://localhost:8080'
      end
    end

    context 'when 80 port does not exists' do
      it 'returns nil' do
        allow(decorated).to receive(:vm_ports).and_return({})
        expect(decorated.http_url).to eq nil
      end
    end
  end

  describe '#htts_url' do
    context 'when 443 port exists' do
      it 'returns http://localhost:8080' do
        allow(decorated).to receive(:vm_ports).and_return({"0"=>{"guest"=>"443", "host"=>"8081"}})
        expect(decorated.https_url).to eq 'https://localhost:8081'
      end
    end

    context 'when 443 port does not exists' do
      it 'returns nil' do
        allow(decorated).to receive(:vm_ports).and_return({})
        expect(decorated.https_url).to eq nil
      end
    end
  end
end
