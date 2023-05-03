class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post'

  def update_post_counter(post)
    post.update(comments_counter: Comment.where(post_id: id).count)
  end
end
