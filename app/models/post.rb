class Post < ApplicationRecord
  WORDS_AND_MEANINGS = 10

  belongs_to :user
  belongs_to :genre
  has_many :word_meanings, dependent: :destroy
  has_many :words, dependent: :destroy
  has_many :meanings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :line_posts, dependent: :destroy
  
  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["genre_id"]
  end
end
