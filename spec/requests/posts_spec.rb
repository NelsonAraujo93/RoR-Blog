require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders index template' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'renders a successful response' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it 'Test if users/:user_id/posts is loading correctly the body' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create(name: 'John', posts_counter: 0) }
    let(:post) { Post.create(author: user, title: 'This is a title', comments_counter: 0, likes_counter: 0) }

    it 'renders show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'renders a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'Test if /users/:user_id/posts/:id is loading correctly the body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('This is the detail view from a given post from the given user')
    end
  end
end
