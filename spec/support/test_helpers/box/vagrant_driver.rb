require 'open-uri'

module TestHelpers
  module Box

    class VagrantDriver
      def initialize(dir:, env:)
        @dir = dir
        @env = env
        @destroyed = false
      end

      def up(provision: false)
        args = %w(up)
        args << '--no-provision' unless provision
        run 'up', args
      end

      def destroy
        run 'destroy', ['-f']
        @destroyed = true
      end

      def destroyed?
        @destroyed
      end

      private

      def run(command, args)
        Dir.chdir(@dir) do
          system "vagrant #{command} #{args.join(' ')}"
        end
      end
    end

  end
end
