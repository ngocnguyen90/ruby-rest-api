class CryptoSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :created_at, :updated_at
  has_one :crypto_type, class_name: 'crypto_type', foreign_key: 'crypto_type_id'
  has_one :user, class_name: 'user', foreign_key: 'user_id'
end
