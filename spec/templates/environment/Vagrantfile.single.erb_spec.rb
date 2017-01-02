RSpec.describe 'templates/environment/virtualbox/Vagrantfile.single.erb' do
  let(:base_params)  { params_fixture.merge(target: 'virtualbox').merge(params_fixture[:development]) }
  let(:params)       { base_params }
  let(:context)      { Templates::Context.new(Rails.root.join('templates/environment/virtualbox/Vagrantfile.single.erb'), params) }

  let(:template) { Tilt.new 'templates/environment/virtualbox/Vagrantfile.single.erb' }
  subject { template.render(context, params: params) }

  context 'vm_share_type' do
    context 'default' do
      let(:params) { base_params.merge(:vm_share_type => 'virtualbox') }

      it 'does not sets synced folder type' do
        expect(subject).to include %Q(.vm.synced_folder '../../', '/myapp'\n)
      end
    end

    context 'nfs' do
      let(:params) { base_params.merge(:vm_share_type => 'nfs') }

      it 'sets nfs synced folder type' do
        expect(subject).to include %Q(.vm.synced_folder '../../', '/myapp', :type => 'nfs')
      end
    end

    context 'smb' do
      let(:params) { base_params.merge(:vm_share_type => 'smb') }

      it 'sets smb synced folder type' do
        expect(subject).to include %Q(.vm.synced_folder '../../', '/myapp', :type => 'smb')
      end
    end
  end

  context 'hostmanager' do
    let(:params)       { base_params.merge(:use_hostname => true) }

    it 'should set the host aliases' do
      expect(subject).to include %Q(.hostmanager.aliases = %w(www.testapp.dev *.testapp.dev))
      expect(subject).to include %Q(.vm.hostname = 'testapp.dev')
    end
  end

end
