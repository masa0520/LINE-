class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_one_attached :image
  has_many :words
  has_many :meanings
  has_many :posts
  has_many :bookmarks, dependent: :destroy
  #user.bookmarks.map(&:post)と同義
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :word_memories, dependent: :destroy
  
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  def word_memorized?(wo)
    WordMemory.find_by(word_id: wo.id)
  end

  def en_memorized?(en)
    WordMemory.find_by(english_word_id: en.id)
  end

  def jp_memorized?(jp)
    WordMemory.find_by(japanese_word_id: jp.id)
  end

end
