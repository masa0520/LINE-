class AddPostIdToEnglishWords < ActiveRecord::Migration[7.0]
  def change
    add_reference :english_words, :post, foreign_key: true
  end
end
