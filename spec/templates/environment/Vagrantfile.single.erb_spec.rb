describe 'templates/Vagrantfile.single.erb' do
  let(:base_params)  { params_fixture.merge(target: 'virtualbox').merge(params_fixture[:development]) }
  let(:params)       { base_params }
  let(:context)      { TemplateContext.new(params) }

  let(:template) { Tilt.new 'templates/environment/Vagrantfile.single.erb' }
  subject { template.render(context, params: params) }

  context 'vm_share_type' do
    context 'default' do
      let(:params) { base_params.merge(:vm_share_type => nil) }

      it 'does not sets synced folder type' do
        puts params[:vm_share_type].inspect
        expect(subject).to include %Q(.vm.synced_folder '../', '/vagrant'\n)
      end
    end

    context 'nfs' do
      let(:params) { base_params.merge(:vm_share_type => 'nfs') }

      it 'sets nfs synced folder type' do
        expect(subject).to include %Q(.vm.synced_folder '../', '/vagrant', :type => 'nfs')
      end
    end

    context 'smb' do
      let(:params) { base_params.merge(:vm_share_type => 'smb') }

      it 'sets smb synced folder type' do
        expect(subject).to include %Q(.vm.synced_folder '../', '/vagrant', :type => 'smb')
      end
    end
  end
end
