require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Nelson', posts_counter: 0) }
  subject { Post.create(author: user, title: 'This is a title', likes_counter: 0, comments_counter: 0) }

  before { subject.save }

  it 'title should be present, expected false' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'title should be present, expected true' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.title = t + t1 + t2 + t3
    expect(subject).to_not be_valid
  end

  it 'likes_counter has to be greater or equal to 0, expected false' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likess_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end

  it 'likes_counter has to be greater or equal to 0, expected true' do
    subject.likes_counter = 1
    expect(subject).to be_valid
  end

  it 'comments_counter has to be greater or equal to 0, expected false' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'commentss_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end

  it 'comments_counter has to be greater or equal to 0, expected true' do
    subject.comments_counter = 1
    expect(subject).to be_valid
  end
  after { subject.save }

  let(:user_one) { User.create(name: 'Nelson', posts_counter: 0) }
  let(:post_one) { Post.create(author: user_one, title: 'This is a title', likes_counter: 0, comments_counter: 0) }

  it 'last_five comments methods should return the last 5 comments related to the post' do
    Comment.create(text: 'This is the comment #0', post: post_one, author: user_one)
    Comment.create(text: 'This is the comment #1', post: post_one, author: user_one)
    Comment.create(text: 'This is the comment #2', post: post_one, author: user_one)
    Comment.create(text: 'This is the comment #3', post: post_one, author: user_one)
    Comment.create(text: 'This is the comment #4', post: post_one, author: user_one)
    Comment.create(text: 'This is the comment #5', post: post_one, author: user_one)
    expect(post_one.last_five_comments.length).to equal(5)
  end

  it 'update_post_counter methods should increment user posts_counter by one' do
    Post.create(author: user_one, title: 'This is a title', likes_counter: 0, comments_counter: 0)
    expect(user_one.posts_counter).to equal(1)
  end
end
