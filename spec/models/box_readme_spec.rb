require 'rails_helper'

describe BoxReadme do
  let(:box) { Box.create! params: params_fixture }

  subject { described_class.new(box, os) }

  describe 'Mac' do
    let(:os) { :mac }
  end

  describe 'Linux' do
    let(:os) { :linux }
  end

  describe 'Windows' do
    let(:os) { :windows }
  end
end
