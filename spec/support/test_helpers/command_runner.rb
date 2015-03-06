module TestHelpers
  class CommandRunner
    def self.run(env: {}, cmd:, dir:)
      new(env: env, cmd: cmd, dir: dir).run
    end

    def initialize(env:, cmd:, dir:)
      @env = env
      @cmd = cmd
      @dir = dir
    end

    def run
      Dir.chdir(@dir) do
        puts "\nRunning '#{@cmd}' in '#{@dir}'\n"
        system(@env, @cmd) or raise 'Command exited with non-zero status'
      end
    end
  end
end
