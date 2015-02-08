describe DataMigrations::Environments do
  subject { described_class.new(Rails.logger) }

  describe '#run' do
    let(:old_params) do
      params_fixture.except(:environments, :development).merge(
        autoconf: true,
        vm_memory: '1024',
        vm_swap: '1024',
        vm_cores: '2',
        vm_shared_directory: '/vagrant',
        vm_share_type: 'nfs',
        vm_ip: '192.168.20.50',
        vm_ports: {
          '0' => { guest: 80,  host: 8080 },
          '1' => { guest: 443, host: 8081 }
        },
      )
    end

    let!(:old_box) { Box.create! params: old_params }
    let!(:new_box) { Box.create! params: params_fixture.merge(environments: %w(development staging)) }

    before { subject.run }
    before { old_box.reload }
    before { new_box.reload }

    context 'old boxes' do
      it 'appends environments key to box without this key' do
        expect(old_box.params['environments']).to eq %w(development)
      end

      it 'moves virtualbox attributes under development section' do
        expect(old_box.params['development']).to include(
          'target'    => 'virtualbox',
          'autoconf'  => true,
          'vm_memory' => '1024',
        )
      end
    end

    context 'new boxes' do
      it 'does not resets environments key if it already present' do
        expect(new_box.params['environments']).to eq %w(development staging)
      end
    end
  end
end
