require 'rails_helper'

feature 'Generate configuration' do
  scenario 'User generates new configuration' do
    visit '/'
    click_button I18n.t('dashboard.show.generate')

    expect(page.response_headers['Content-Disposition']).to eq 'attachment'
  end
end
