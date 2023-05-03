require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Nelson', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'This is a title', likes_counter: 0, comments_counter: 0) }

  it 'update_comments_counter methods should increment user comments_counter by one' do
    Comment.create(author: user, text: 'This is a title', post: post)
    expect(post.comments_counter).to equal(1)
  end
end