class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorites_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.search_for(word, method)
    if method == 'perfect_match'
      Book.where(title: word)
    elsif method == 'forward_match'
      Book.where('title LIKE?', word + '%')
    elsif method == 'backward_match'
      Book.where('title LIKE?', '%' + word)
    else
      Book.where('title LIKE?', '%' + word + '%')
    end
  end
end
