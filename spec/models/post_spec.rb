require 'rails_helper'

RSpec.describe Post, type: :system do
  let(:user) { User.new(name: 'Nelson', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Nelson bio') }
  subject do
    Post.create(author: user, title: 'This is a title', text: 'And this is the post body', likes_counter: 0,
                comments_counter: 0)
  end
  let(:kender) { User.new(name: 'Kender', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Kender bio') }
  let(:post_one) { Post.new(author: user, title: 'This is a title 2', likes_counter: 0, comments_counter: 0) }
  let(:post_two) { Post.new(author: user, title: 'This is a title 3', likes_counter: 0, comments_counter: 0) }
  let(:post_three) { Post.new(author: user, title: 'This is a title 4', likes_counter: 0, comments_counter: 0) }
  let(:comment) { Comment.new(text: 'This is the comment #0', post: subject, author: user) }

  before { subject.save }
  before { kender.save }
  before { user.save }
  before { post_one.save }
  before { post_two.save }
  before { post_three.save }
  before { comment.save }

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
    expect(user_one.posts_counter).to equal(3)
  end
end
