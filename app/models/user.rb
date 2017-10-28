class User < ApplicationRecord
  include BCrypt

  after_validation :encrypt_password
  has_secure_token :key
  after_commit :queue_account_key_job

  validates :email, presence: true, uniqueness: true, length: { in: 1..200 }
  validates :phone_number, presence: true, uniqueness: true, length: { in: 1..20 }, case_sensitive: false
  validates :password, presence: true, length: { in: 1..100 }

  validates :full_name, length: { maximum: 200 }
  validates :account_key, uniqueness: true, allow_nil: true, length: { maximum: 100 }
  validates :metadata, length: { maximum: 2000 }

  def encrypt_password
    self.password = Password.create(password)
  end

  def queue_account_key_job
    AccountKeyJob.perform_later(self.id)
  end
end
