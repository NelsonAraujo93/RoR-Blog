require 'rails_helper'

RSpec.describe User, type: :system do
  subject { User.new(name: 'Nelson', posts_counter: 2, photo:'https://picsum.photos/300/300') }
  let(:kender) {User.new(name: 'Kender', posts_counter: 0, photo:'https://picsum.photos/300/300')}
  before { subject.save }
  before { kender.save }
  describe 'index page' do
    it 'shows the rendering of user Kender name' do
      visit '/'
      sleep(2)
      expect(page).to have_content('Kender')
    end
    it 'shows the rendering of user Nelson name' do
      visit '/'
      sleep(2)
      expect(page).to have_content('Nelson')
    end
    it 'show the images from user Kender' do
      visit '/'
      sleep(4)
      expect(page.find("#user-#{kender.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'show the images from user Nelson' do
      visit '/'
      sleep(4)
      expect(page.find("#user-#{subject.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'show the posts_counter from user Kender' do
      visit '/'
      sleep(2)
      expect(page.find("#counter-#{kender.id}")).to have_content kender.posts_counter.to_s
    end
    it 'show the posts_counter from user Nelson' do
      visit '/'
      sleep(2)
      expect(page.find("#counter-#{subject.id}")).to have_content subject.posts_counter.to_s
    end
    it 'redirects from user index to user show Nelson' do
      visit '/' # Visit the user index page
      sleep(2)
      find('span', text: subject.name).click # Click on the user's link
      expect(page).to have_current_path("/users/#{subject.id}", ignore_query: true) # Verify the redirection to user show page
    end
    it 'redirects from user index to user show Kender' do
      visit '/' # Visit the user index page
      sleep(2)
      find('span', text: kender.name).click # Click on the user's link
      expect(page).to have_current_path("/users/#{kender.id}", ignore_query: true) # Verify the redirection to user show page
    end
  end
  describe 'show page' do
    it "should display the user's profile picture." do
      visit "/users/#{subject.id}"
      sleep(2)
      expect(page.find("img")['src']).to have_content subject.photo
    end
  end

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
