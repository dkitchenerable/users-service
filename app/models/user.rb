class User < ApplicationRecord
  #after_commit :queue_account_service
  #before_save  :key_generation

  validates :email, presence: true, uniqueness: true, length: { in: 1..200 }
  validates :phone_number, presence: true, uniqueness: true, length: { in: 1..20 }, case_sensitive: false
  validates :password, presence: true, length: { in: 1..100 }
  validates :key, presence: true, uniqueness: true, length: { in: 1..100 }

  validates :full_name, length: { maximum: 200 }
  validates :account_key, uniqueness: true, allow_nil: true, length: { maximum: 100 }
  validates :metadata, length: { maximum: 2000 }

  private

  def key_generation
    # do something
  end

  def queue_account_service
    #call AccountServiceWorker
  end
end
