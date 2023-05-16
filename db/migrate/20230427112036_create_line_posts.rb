class CreateLinePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :line_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.datetime :set_time
      t.timestamps
    end
  end
end
