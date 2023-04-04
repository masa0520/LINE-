class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.references :english_word, null: false, foreign_key: true
      t.references :japanese_word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
