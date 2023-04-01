class Post < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :destroy
  has_many :english_words, dependent: :destroy
  has_many :japanese_words, dependent: :destroy
  
  validates :title, presence: true
end
