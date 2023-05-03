class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  def update_post_counter(post)
    post.update(likes_counter: Like.where(post_id: post.id).count)
  end
end
