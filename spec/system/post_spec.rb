require 'rails_helper'

RSpec.describe Post, type: :system do
  let(:user) { User.new(name: 'Nelson', posts_counter: 0, photo:'https://picsum.photos/300/300',bio:'Nelson bio') }
  subject { Post.create(author: user, title: 'This is a title', text:'And this is the post body', likes_counter: 0, comments_counter: 0) }
  let(:kender) {User.new(name: 'Kender', posts_counter: 0, photo:'https://picsum.photos/300/300',bio:'Kender bio')}
  let(:post_1) { Post.new(author: user, title: 'This is a title 2', likes_counter: 0, comments_counter: 0) }
  let(:post_2) { Post.new(author: user, title: 'This is a title 3', likes_counter: 0, comments_counter: 0) }
  let(:post_3) { Post.new(author: user, title: 'This is a title 4', likes_counter: 0, comments_counter: 0) }
  let(:comment) { Comment.new(text: 'This is the comment #0', post: subject, author: user)}

  before { subject.save }
  before { kender.save }
  before { user.save }
  before {post_1.save}
  before {post_2.save}
  before {post_3.save}
  before {comment.save}

  # INDEX PAGE CAPYBARA
  describe 'index page' do
    it 'show the user profile picture' do
      visit "/users/#{user.id}/posts"
      expect(page.find("img")['src']).to have_content user.photo
    end
    it 'shows the User name' do
      visit "/users/#{user.id}/posts"
      expect(page).to have_content(user.name)
    end
    it 'show the posts_counter from user profile' do
      visit "/users/#{user.id}/posts"
      expect(page.find(".custom-card-t")).to have_content user.posts_counter.to_s
    end
    it 'Show the post title on posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page).to have_content subject.title
    end
    it 'Show the post body on posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page).to have_content subject.text
    end
    it 'Show the first comment of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page).to have_content comment.text
    end
    it 'Show the number of comments of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page.find("#comments-#{subject.id}")).to have_content subject.comments_counter.to_s
    end
    it 'Show the number of likes of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page.find("#likes-#{subject.id}")).to have_content subject.likes_counter.to_s
    end
    it 'Show the see all post button of a posts#index' do
      visit "/users/#{user.id}/posts"
      expect(page).to have_content('Pagination')
    end
    it 'redirects from post#index to post#show' do
      visit "/users/#{user.id}/posts" # Visit the user index page
      find("#test-#{subject.id}", text: subject.title).click # Click on the user's link
      expect(page).to have_current_path("/users/#{user.id}/posts/#{subject.id}", ignore_query: true) # Verify the redirection to user show page
    end
  end
  # SHOW PAGE CAPYBARA
  describe 'show page' do
    it 'Show the post title on posts#show' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page).to have_content subject.title
    end
    it 'shows the User name who owns the post' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page).to have_content(user.name)
    end
    it 'Show the number of comments of a post on posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find(".counter-data")).to have_content subject.comments_counter.to_s
    end
    it 'Show the number of likes of a post on posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find(".counter-data")).to have_content subject.likes_counter.to_s
    end
    it 'Show the text or body of the post on post#show' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find(".post-data-main")).to have_content subject.text
    end
    it 'Show the name of the comment owner of a post on posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find("#comment-#{comment.id}")).to have_content user.name
    end
    it 'Show the text of the comment of a post on posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find("#comment-#{comment.id}")).to have_content comment.text
    end
  end
end
