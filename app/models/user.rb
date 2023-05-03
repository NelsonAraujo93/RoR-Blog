class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  
  def last_three_posts
    posts = Post.where(author_id: self.id).last(3)
  end

end
