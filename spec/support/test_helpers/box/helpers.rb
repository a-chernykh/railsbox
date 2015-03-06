require 'delegate'

module TestHelpers
  module Box
    module Helpers
      def test_box(opts)
        zip = BoxDownloader.new(opts.merge(context: self)).zip_contents
        dir = extract_zip(zip)

        result = BoxTester.new(opts.merge(dir: dir)).test
        FileUtils.remove_entry_secure(dir) if result

        expect(result).to eq true
      end
    end
  end
end
