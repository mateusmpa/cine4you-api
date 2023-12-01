# frozen_string_literal: true

class AddNameToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :name, :string
  end
end
