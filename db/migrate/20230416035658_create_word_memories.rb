class CreateWordMemories < ActiveRecord::Migration[7.0]
  def change
    create_table :word_memories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :english_word, null: true, foreign_key: true
      t.references :japanese_word, null: true, foreign_key: true
      t.references :word, null: true, foreign_key: true

      t.timestamps
    end
  end
end
