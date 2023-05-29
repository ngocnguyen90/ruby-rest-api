class CryptoType < ApplicationRecord
  has_many :cryptos
  validates :name, presence: true
end
