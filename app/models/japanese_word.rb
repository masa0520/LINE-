class JapaneseWord < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :destroy
  has_many :english_words, through: :words
end
