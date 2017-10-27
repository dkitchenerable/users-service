class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, length: { in: 1..200 }
  validates :phone_number, presence: true, uniqueness: true, length: { in: 1..20 }, case_sensitive: false
  validates :password, presence: true, length: { in: 1..100 }
  validates :key, presence: true, uniqueness: true, length: { in: 1..100 }

  validates :full_name, length: { maximum: 200 }
  validates :account_key, uniqueness: true, length: { maximum: 100 }
  validates :metadata, length: { maximum: 2000 }

end
