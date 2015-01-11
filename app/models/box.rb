class Box < ActiveRecord::Base
  store_accessor :params, :vm_name, :vm_shared_directory, :vm_ports, :server_type

  validates :params, presence: true
  validates :secure_id, presence: true, uniqueness: true
  validates :vm_name, format: { with: /\A[a-z0-9.-]+\z/i, allow_nil: true }

  before_validation :generate_secure_id, on: :create

  def self.databases
    [ OpenStruct.new({ id: 'postgresql', name: 'PostgreSQL' }),
      OpenStruct.new({ id: 'mysql',      name: 'MySQL' }),
      OpenStruct.new({ id: 'mongodb',    name: 'MongoDB' }),
      OpenStruct.new({ id: 'redis',      name: 'Redis' }), ]
  end

  def self.background_jobs
    [ OpenStruct.new({ id: 'delayed_job', name: 'delayed_job' }), 
      OpenStruct.new({ id: 'sidekiq',     name: 'sidekiq' }),
      OpenStruct.new({ id: 'resque',      name: 'resque' }), ]
  end

  def to_param
    secure_id
  end

  def as_json(opts = {})
    params
  end

  private

  def generate_secure_id
    self.secure_id = SecureIdGenerator.generate
  end
end
