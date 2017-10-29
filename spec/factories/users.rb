FactoryBot.define do
  after(:create) { |c| c.index! }
  factory :user do
    email { Faker::Internet.email }
    phone_number { Faker::Number.number(10) }
    password { Faker::Internet.password(10) }
  end
end
