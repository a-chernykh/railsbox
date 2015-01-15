class Databases
  def self.list
    [ OpenStruct.new({ id: 'postgresql', name: 'PostgreSQL', port: 5432 }),
      OpenStruct.new({ id: 'mysql',      name: 'MySQL',      port: 3306 }),
      OpenStruct.new({ id: 'mongodb',    name: 'MongoDB',    port: 27017 }),
      OpenStruct.new({ id: 'redis',      name: 'Redis',      port: 6379 }), ]
  end

  def self.port_for(name)
    list.detect { |db| db.id == name }.try(:[], :port)
  end
end
