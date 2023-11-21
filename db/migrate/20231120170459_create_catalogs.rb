class CreateCatalogs < ActiveRecord::Migration[7.1]
  def change
    create_table :catalogs do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
