class EnglishWord < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :destroy
  has_many :japanese_words, through: :words
end
