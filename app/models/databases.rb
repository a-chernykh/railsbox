class Databases
  def self.list
    [ OpenStruct.new({ id: 'postgresql', port: 5432 }),
      OpenStruct.new({ id: 'mysql',      port: 3306 }),
      OpenStruct.new({ id: 'mongodb',    port: 27017 }),
      OpenStruct.new({ id: 'redis',      port: 6379 }), ]
  end

  def self.port_for(id)
    list.detect { |db| db.id == id }.try(:[], :port)
  end
end
