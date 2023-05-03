class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post'
  after_save :update_post_counter

  private

  def update_post_counter
    post.increment!(:likes_counter)
  end
end
