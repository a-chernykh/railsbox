require 'rails_helper'

describe ConfigurationsController do
  describe 'POST create' do
    it 'responds with file download' do
      post :create, params_fixture
      expect(response.headers['Content-Disposition']).to include 'attachment'
    end
  end
end
