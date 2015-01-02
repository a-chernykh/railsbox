class Box < ActiveRecord::Base
  validates :params, presence: true
  validates :secure_id, presence: true, uniqueness: true

  before_validation :generate_secure_id, on: :create

  def to_param
    secure_id
  end

  def name
    params['vm_name']
  end

  private

  def generate_secure_id
    self.secure_id = SecureIdGenerator.generate
  end
end
