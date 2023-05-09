require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'renders a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'Test if /users is loading correctly the body' do
      get '/users'
      expect(response.body).to include('This is a list of users')
    end
  end

  describe 'GET /show' do
    it 'renders show template' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'renders a successful response' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'Test if /users/:id is loading correctly the body' do
      user = User.create(name: 'Nelson', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response.body).to include('Here is detail view from a given user')
    end
  end
end
