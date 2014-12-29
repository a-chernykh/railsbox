require 'rails_helper'

describe CopyConfiguration do
  describe '#save' do
    before { @dir = Dir.mktmpdir }
    before { subject.save(@dir) }

    %w(.gitignore ansible/roles/base/tasks/main.yml).each do |file|
      it "copies #{file}" do
        input_file = File.join(Templates::ROOT_PATH, file)
        target_file = File.join(@dir, file)
        expect(File).to exist(target_file)
        expect(IO.read(input_file)).to eq IO.read(target_file)
      end
    end

    it 'does not copies files with .erb extension' do
      expect(File).not_to exist(File.join(@dir, 'Vagrantfile.erb'))
    end

    after { FileUtils.remove_entry_secure @dir }
  end
end
