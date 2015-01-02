require 'rails_helper'

describe BoxesController do
  describe 'POST create' do
    before do
      allow(SecureIdGenerator).to receive(:generate) { 'abc123' }
      post :create, params_fixture
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
    it 'renders 404 for non-existing box' do
      expect { get(:show, id: 'nonexisting') }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'loads the box' do
      box = Box.create! params: params_fixture
      get :show, id: box.secure_id
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
