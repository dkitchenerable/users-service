FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { Faker::Number.number(10) }
    password { Faker::Internet.password(10) }
    key { Faker::Crypto.sha1 }
  end
end
