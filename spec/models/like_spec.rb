require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Nelson', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'This is a title', likes_counter: 0, comments_counter: 0) }

  it 'update_likes_counter methods should increment user likes_counter by one' do
    Like.create(author: user, post: post)
    expect(post.likes_counter).to equal(1)
  end
end