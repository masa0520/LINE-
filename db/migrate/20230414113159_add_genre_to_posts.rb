class AddGenreToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :genre, null: false, foreign_key: true
  end
end
