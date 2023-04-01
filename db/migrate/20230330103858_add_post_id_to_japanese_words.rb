class AddPostIdToJapaneseWords < ActiveRecord::Migration[7.0]
  def change
    add_reference :japanese_words, :post, foreign_key: true
  end
end
