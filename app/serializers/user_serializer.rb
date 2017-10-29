class UserSerializer < ActiveModel::Serializer
  cache key: 'user'

  attributes :email, :phone_number, :full_name, :key, :account_key, :metadata
end
