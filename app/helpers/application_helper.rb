module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def site_name
    'rubyops'.freeze
  end

  def databases
    [ OpenStruct.new({ id: 'postgresql', name: 'PostgreSQL' }),
      OpenStruct.new({ id: 'mysql',      name: 'MySQL' }),
      OpenStruct.new({ id: 'mongodb',    name: 'MongoDB' }), ]
  end
end
