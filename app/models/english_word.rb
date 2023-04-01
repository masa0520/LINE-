class EnglishWord < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :words, dependent: :destroy
  has_many :japanese_words, through: :words

end
