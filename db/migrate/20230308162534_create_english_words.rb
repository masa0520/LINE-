class CreateEnglishWords < ActiveRecord::Migration[7.0]
  def change
    create_table :english_words do |t|
      t.string :english
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
