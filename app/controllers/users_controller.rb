class UsersController < ApplicationController
  protect_from_forgery prepend: true

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.last_three_posts
  end
end
