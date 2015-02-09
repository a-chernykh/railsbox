module DataMigrations
  class Environments
    def initialize(logger)
      @logger = logger
    end

    def run
      Box.find_each do |box|
        if old?(box)
          @logger.info "Migrating Box##{box.secure_id}"
          
          params = box.params

          params['environments'] = %w(development)
          params['development'] = { target: 'virtualbox' }
          %w(autoconf vm_memory vm_swap vm_cores 
             vm_share_type vm_ip vm_ports).each do |attr|
            params['development'][attr] = params[attr]
          end
          params['path'] = params.delete('vm_shared_directory')

          box.update_columns params: params
        end
      end
    end

    private

    def old?(box)
      box.params['environments'].blank?
    end
  end
end
