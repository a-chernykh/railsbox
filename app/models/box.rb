class Box < ActiveRecord::Base
  store_accessor :params, :vm_name, :server_type, :development, :production, :staging, :path

  validates :params, presence: true
  validates :secure_id, presence: true, uniqueness: true
  validates :vm_name, format: { with: /\A[a-z0-9_.-]+\z/i, allow_nil: true }

  before_validation :generate_secure_id, on: :create

  def self.background_jobs
    [ OpenStruct.new({ id: 'delayed_job', name: 'delayed_job' }),
      OpenStruct.new({ id: 'sidekiq',     name: 'sidekiq' }),
      OpenStruct.new({ id: 'resque',      name: 'resque' }), ]
  end

  def to_param
    secure_id
  end

  def as_json(opts = {})
    DefaultConfiguration.base.merge(params.symbolize_keys)
  end

  private

  def generate_secure_id
    tries = 10
    loop do
      self.secure_id = SecureIdGenerator.generate
      break if !self.class.exists?(secure_id: secure_id) || tries == 0
      tries -= 1
    end
  end
end
