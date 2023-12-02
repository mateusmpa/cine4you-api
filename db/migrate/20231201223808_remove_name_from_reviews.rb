class RemoveNameFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_column :reviews, :name, :string
  end
end
