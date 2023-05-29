class CreateCryptos < ActiveRecord::Migration[7.0]
  def change
    create_table :cryptos do |t|
      t.string(:name, null: false)
      t.float(:price, null: false)
      t.references(:crypto_type, foreign_key: true)
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
