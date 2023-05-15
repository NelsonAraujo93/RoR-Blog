class PostsController < ApplicationController
  def index
    @user = User.includes({posts: {comments: :author} }).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @like_state = false
    @post = Post.find(params[:id])
    @post.likes.each do |like|
      @like_state = like.author_id == current_user.id
    end
  end

  def new
    new_post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: new_post } }
    end
  end

  def create
    @new_post = Post.new(params.require(:post).permit(:text, :title))
    @new_post.author = current_user
    @new_post.likes_counter = 0
    @new_post.comments_counter = 0
    respond_to do |format|
      if @new_post.save
        format.html { redirect_to "/users/#{current_user.id}/posts", notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
