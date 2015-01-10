class Box < ActiveRecord::Base
  store_accessor :params, :vm_name, :vm_shared_directory, :vm_ports

  validates :params, presence: true
  validates :secure_id, presence: true, uniqueness: true
  validates :vm_name, format: { with: /\A[a-z0-9.-]+\z/i, allow_nil: true }

  before_validation :generate_secure_id, on: :create

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
