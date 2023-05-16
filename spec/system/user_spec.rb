require 'rails_helper'

RSpec.describe User, type: :system do
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

  describe 'index page' do
    it 'shows the rendering of user Kender name' do
      visit '/'
      expect(page).to have_content('Kender')
    end
    it 'shows the rendering of user Nelson name' do
      visit '/'
      expect(page).to have_content('Nelson')
    end
    it 'show the images from user Kender' do
      visit '/'
      expect(page.find("#user-#{kender.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'show the images from user Nelson' do
      visit '/'
      expect(page.find("#user-#{subject.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'show the posts_counter from user Kender' do
      visit '/'
      expect(page.find("#counter-#{kender.id}")).to have_content kender.posts_counter.to_s
    end
    it 'show the posts_counter from user Nelson' do
      visit '/'
      expect(page.find("#counter-#{subject.id}")).to have_content subject.posts_counter.to_s
    end
    it 'redirects from user index to user show Nelson' do
      visit '/' # Visit the user index page
      find('span', text: subject.name).click
      expect(page).to have_current_path("/users/#{subject.id}", ignore_query: true)
    end
    it 'redirects from user index to user show Kender' do
      visit '/' # Visit the user index page
      find('span', text: kender.name).click
      expect(page).to have_current_path("/users/#{kender.id}", ignore_query: true)
    end
  end

  # USER SHOW PAGE
  describe 'User show page' do
    it "should display the user's profile picture." do
      visit "/users/#{subject.id}"
      expect(page.find('img')['src']).to have_content subject.photo
    end
    it 'should render the username of the user' do
      visit "/users/#{subject.id}"
      expect(page).to have_content(subject.name)
    end

    it 'should render the  number of posts the user has written.' do
      visit "/users/#{subject.id}"
      expect(page.find('.custom-card-t')).to have_content subject.posts_counter.to_s
    end

    it 'should render the  bio of the user' do
      visit "/users/#{subject.id}"
      expect(page.find('.bio')).to have_content subject.bio.to_s
    end

    it 'should render the  3 first posts of the user' do
      visit "/users/#{subject.id}"
      expect(page).to have_selector('.post-item', count: 3)
    end

    it 'should render a button that lets me view all the posts of the user' do
      visit "/users/#{subject.id}"
      expect(page).to have_content 'See all posts'
    end

    it 'should redirect me to the show page of that post when the user clicks on the post' do
      visit "/users/#{subject.id}"
      find("#show-post-#{first_post.id}").click
      expect(page).to have_current_path("/users/#{subject.id}/posts/#{first_post.id}", ignore_query: true)
    end

    it 'should redirect me to the post index page when the user clicks on see all posts' do
      visit "/users/#{subject.id}"
      find('#all-posts').click
      expect(page).to have_current_path("/users/#{subject.id}/posts", ignore_query: true)
    end
  end
end
