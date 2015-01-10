describe BoxesController do
  describe 'POST create' do
    before do
      allow(SecureIdGenerator).to receive(:generate) { 'abc123' }
      post :create, box: params_fixture
    end

    let(:box) { Box.where(secure_id: 'abc123').first }

    it 'creates new configuration in database' do
      expect(box).to be_present
      expect(box.params['databases']).to include 'postgresql'
    end

    it 'redirects to the box page' do
      expect(response).to redirect_to(box_url(box))
    end
  end

  describe 'GET show' do
    let(:box) { Box.create! params: params_fixture }

    it 'renders 404 for non-existing box' do
      expect { get(:show, id: 'nonexisting') }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'loads the box' do
      get :show, id: box.secure_id
      expect(assigns(:box)).to eq box
    end

    it 'responds with json' do
      get :show, id: box.secure_id, format: :json
      json = JSON.parse(response.body)
      expect(json['vm_name']).to eq 'testapp'
    end
  end

  describe 'GET default' do
    it 'responds with json' do
      get :default, format: :json
      json = JSON.parse(response.body)
      expect(json['vm_name']).to eq 'myapp'
    end
  end

  describe 'GET edit' do
    it 'renders 404 for non-existing box' do
      expect { get(:edit, id: 'nonexisting') }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'loads the box' do
      box = Box.create! params: params_fixture
      get :edit, id: box.secure_id
      expect(assigns(:box)).to eq box
    end
  end

  describe 'GET download' do
    it 'responds with file download' do
      box = Box.create! params: params_fixture
      get :download, id: box.secure_id
      expect(response.headers['Content-Disposition']).to include 'attachment'
    end
  end
end
