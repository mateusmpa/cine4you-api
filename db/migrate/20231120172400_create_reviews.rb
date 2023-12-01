# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :catalog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
