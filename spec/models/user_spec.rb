require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Nelson', posts_counter: 2, photo: 'https://picsum.photos/300/300', bio: 'Nelson bio') }
  let(:kender) { User.new(name: 'Kender', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Kender bio') }
  let(:first_post) { Post.new(author: subject, title: 'This is a title', likes_counter: 0, comments_counter: 0) }
  let(:second_post) { Post.new(author: subject, title: 'This is a title', likes_counter: 0, comments_counter: 0) }
  let(:third_post) { Post.new(author: subject, title: 'This is a title', likes_counter: 0, comments_counter: 0) }

  before { subject.save }
  before { kender.save }
  before { first_post.save }
  before { second_post.save }
  before { third_post.save }

  it 'name should be present, expected false' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected false' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected true' do
    subject.posts_counter = 1
    expect(subject).to be_valid
  end
  after { subject.save }

  let(:user) { User.new(name: 'Nelson', posts_counter: 0) }

  it 'last_three_post methods should return the last 3 Posts related to the user' do
    Post.create(author: user, title: 'This is a title', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is a title 2', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is a title 3', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is a title 4', likes_counter: 0, comments_counter: 0)
    expect(user.last_three_posts.length).to equal(3)
  end
end
