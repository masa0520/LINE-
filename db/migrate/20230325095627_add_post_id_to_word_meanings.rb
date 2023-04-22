class AddPostIdToWordMeanings < ActiveRecord::Migration[7.0]
  def change
    add_reference :word_meanings, :post, foreign_key: true
  end
end
