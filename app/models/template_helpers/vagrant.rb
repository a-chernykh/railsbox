module TemplateHelpers
  module Vagrant
    def vm_share_type_param
      case params[:vm_share_type]
      when 'nfs', 'smb'
        ", :type => '#{params[:vm_share_type]}'"
      end
    end
  end  
end
