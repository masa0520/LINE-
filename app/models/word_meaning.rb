class WordMeaning < ApplicationRecord
  belongs_to :word
  belongs_to :meaning
  belongs_to :post
  has_many :word_memories, dependent: :destroy
end
