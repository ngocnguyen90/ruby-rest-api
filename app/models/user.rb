class User < ApplicationRecord
  has_secure_password
  has_one :themes, dependent: :destroy
  has_many :cryptos, dependent: :destroy

  has_many :refresh_tokens, dependent: :delete_all
  has_many :whitelisted_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
end
