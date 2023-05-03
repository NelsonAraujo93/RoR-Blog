class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'
  after_save :update_post_counter

  validates :title, presence: true, length: { maximun: 250 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_five_comments
    Comment.where(post_id: id).last(5)
  end

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
