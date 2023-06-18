class Crypto < ApplicationRecord
  belongs_to :crypto_type
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_numeric: true }

  def self.search(query)
    query = begin
      Integer(query)
    rescue StandardError
      query
    end
    if query.is_a? Numeric
      Crypto.includes(:crypto_type).select('cryptos.id, cryptos.name, cryptos.price, crypto_types.name as crypto_type_name, crypto_type_id').where(
        'cryptos.id = :query or cryptos.price = :query', query: "#{query}"
      ).references(:crypto_type)
    else
      Crypto.includes(:crypto_type).select('cryptos.id, cryptos.name, cryptos.price, crypto_types.name as crypto_type_name, crypto_type_id').where('cryptos.name LIKE :query
        or cast(cryptos.price as text) LIKE :query or crypto_types.name LIKE :query', query: "%#{query}%").references(:crypto_type)
    end
  end
end
