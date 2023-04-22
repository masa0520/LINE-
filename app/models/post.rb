class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :word_meanings, dependent: :destroy
  has_many :words, dependent: :destroy
  has_many :meanings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  validates :title, presence: true

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["genre_id"]
  end
end
