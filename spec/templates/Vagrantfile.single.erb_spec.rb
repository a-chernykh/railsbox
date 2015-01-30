describe 'templates/Vagrantfile.single.erb' do
  let(:params)  { params_fixture }
  let(:context) { TemplateContext.new(params) }

  let(:template) { Tilt.new 'templates/Vagrantfile.single.erb' }
  subject { template.render(context, params: params) }

  context 'vm_share_type' do
    context 'default' do
      let(:params) { params_fixture.merge(:vm_share_type => nil) }

      it 'does not sets synced folder type' do
        expect(subject).to include %Q(config.vm.synced_folder '../', '/vagrant'\n)
      end
    end

    context 'nfs' do
      let(:params) { params_fixture.merge(:vm_share_type => 'nfs') }

      it 'sets nfs synced folder type' do
        expect(subject).to include %Q(config.vm.synced_folder '../', '/vagrant', :type => 'nfs')
      end
    end

    context 'smb' do
      let(:params) { params_fixture.merge(:vm_share_type => 'smb') }

      it 'sets smb synced folder type' do
        expect(subject).to include %Q(config.vm.synced_folder '../', '/vagrant', :type => 'smb')
      end
    end
  end
end
