class WordMemory < ApplicationRecord
  belongs_to :user
  belongs_to :word, optional: true
  belongs_to :meaning, optional: true
  belongs_to :words, optional: true

  #validates :user_id, uniqueness: { scope: :english_word_id }
  #validates :user_id, uniqueness: { scope: :japanese_word_id }
  #validates :user_id, uniqueness: { scope: :word_id }
end
