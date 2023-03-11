class CreateJapaneseWords < ActiveRecord::Migration[7.0]
  def change
    create_table :japanese_words do |t|
      t.string :japanese
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
