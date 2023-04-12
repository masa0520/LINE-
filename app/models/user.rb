class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_one_attached :image
  has_many :japanese_words
  has_many :english_words
  has_many :posts
  has_many :bookmarks, dependent: :destroy
  #user.bookmarks.map(&:post)と同義
  has_many :bookmark_posts, through: :bookmarks, source: :post
  
  def bookmark?(post)
    bookmark_posts.include?(post)
  end
end
