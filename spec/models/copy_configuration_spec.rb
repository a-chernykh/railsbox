describe CopyConfiguration do
  describe '#save' do
    subject { described_class.new(params_fixture) }

    before { @dir = Dir.mktmpdir }
    before { subject.save(@dir) }

    def source_contents(file)
      input_file = File.join(Templates::ROOT_PATH, file)
      IO.read(input_file)
    end

    %w(.gitignore ansible/roles/swap/tasks/main.yml).each do |file|
      it "copies #{file}" do
        target_file = File.join(@dir, file)
        expect(File).to exist(target_file)
        expect(source_contents(file)).to eq IO.read(target_file)
      end
    end

    it 'does not copy roles which are not selected' do
      expect(File).not_to exist(File.join(@dir, 'ansible/roles/mongodb/tasks/main.yml'))
    end

    it 'does copy roles which are included' do
      expect(File).to exist(File.join(@dir, 'ansible/roles/postgresql/tasks/main.yml.erb'))
    end

    describe 'docker' do
      subject { described_class.new(params_fixture.merge(docker: docker)) }

      context '== true' do
        let(:docker) { true }

        it 'copies Vagrantfile.erb from docker source' do
          expect(IO.read(File.join(@dir, 'environment/virtualbox/Vagrantfile.erb'))).to eq(source_contents('environment/virtualbox/Vagrantfile.docker.erb'))
        end

        it 'does not copies Vagrantfile.single.erb' do
          expect(File).not_to exist(File.join(@dir, 'environment/virtualbox/Vagrantfile.single.erb'))
        end

        it 'does not copies Vagrantfile.docker.erb' do
          expect(File).not_to exist(File.join(@dir, 'environment/virtualbox/Vagrantfile.docker.erb'))
        end

        it 'copies Vagrantfile.dockerhost.erb' do
          expect(IO.read(File.join(@dir, 'environment/virtualbox/Vagrantfile.dockerhost.erb'))).to eq(source_contents('environment/virtualbox/Vagrantfile.dockerhost.erb'))
        end
      end

      context '== false' do
        let(:docker) { false }

        it 'copies Vagrantfile.erb from vagrant source' do
          expect(IO.read(File.join(@dir, 'environment/virtualbox/Vagrantfile.erb'))).to eq(source_contents('environment/virtualbox/Vagrantfile.single.erb'))
        end

        it 'does not copies Vagrantfile.docker.erb' do
          expect(File).not_to exist(File.join(@dir, 'environment/virtualbox/Vagrantfile.docker.erb'))
        end

        it 'does not copies Vagrantfile.dockerhost.erb' do
          expect(File).not_to exist(File.join(@dir, 'environment/virtualbox/Vagrantfile.dockerhost.erb'))
        end
      end
    end

    after { FileUtils.remove_entry_secure @dir }
  end
end
