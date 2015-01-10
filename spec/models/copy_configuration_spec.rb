describe CopyConfiguration do
  describe '#save' do
    subject { described_class.new(params_fixture) }

    before { @dir = Dir.mktmpdir }
    before { subject.save(@dir) }

    %w(.gitignore ansible/roles/swap/tasks/main.yml Vagrantfile.erb).each do |file|
      it "copies #{file}" do
        input_file = File.join(Templates::ROOT_PATH, file)
        target_file = File.join(@dir, file)
        expect(File).to exist(target_file)
        expect(IO.read(input_file)).to eq IO.read(target_file)
      end
    end

    it 'does not copy roles which are not selected' do
      expect(File).not_to exist(File.join(@dir, 'ansible/roles/mongodb/tasks/main.yml'))
    end

    it 'does copy roles which are included' do
      expect(File).to exist(File.join(@dir, 'ansible/roles/postgresql/tasks/main.yml'))
    end

    after { FileUtils.remove_entry_secure @dir }
  end
end
