class AddPostIdToWords < ActiveRecord::Migration[7.0]
  def change
    add_reference :words, :post, foreign_key: true
  end
end
