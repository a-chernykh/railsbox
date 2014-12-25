require 'rails_helper'

describe Archiver do
  describe '#archive' do
    let(:zip) { Rails.root.join('tmp/test.zip') }

    before { FileUtils.rm_f zip }

    it 'creates zip archive' do
      described_class.new(Rails.root.join('app/templates')).archive(zip)
      expect(File).to exist(zip)
    end
  end
end
