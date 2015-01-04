require 'rails_helper'

describe Templates do
  describe '.path' do
    it 'returns path to given template' do
      expect(described_class.path('Vagrantfile.erb')).to eq 'templates/Vagrantfile.erb'
    end
  end
end
