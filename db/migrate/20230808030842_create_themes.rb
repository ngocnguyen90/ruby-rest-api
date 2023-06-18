class CreateThemes < ActiveRecord::Migration[7.0]
  def change
    create_table :themes do |t|
      t.string :header_color
      t.string :logo
      t.string :avatar
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
