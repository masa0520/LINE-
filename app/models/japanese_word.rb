class JapaneseWord < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :words, dependent: :destroy
  has_many :english_words, through: :words
  has_many :word_memories, dependent: :destroy

end
