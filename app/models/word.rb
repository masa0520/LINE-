class Word < ApplicationRecord
  belongs_to :english_word
  belongs_to :japanese_word
  belongs_to :post
  has_many :word_memories, dependent: :destroy
end
