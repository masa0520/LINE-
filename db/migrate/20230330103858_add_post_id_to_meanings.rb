class AddPostIdToMeanings < ActiveRecord::Migration[7.0]
  def change
    add_reference :meanings, :post, foreign_key: true
  end
end
