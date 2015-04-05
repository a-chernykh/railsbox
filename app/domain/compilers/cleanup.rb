module Compilers
  class Cleanup
    def save(output_dir)
      FileUtils.remove_entry_secure(File.join(output_dir, 'environment'))
    end
  end
end
