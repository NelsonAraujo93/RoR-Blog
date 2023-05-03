class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def last_five_comments
    Comment.where(post_id: id).last(5)
  end

  def update_post_counter(user)
    user.update(posts_counter: Post.where(author_id: user.id).count)
  end
end
