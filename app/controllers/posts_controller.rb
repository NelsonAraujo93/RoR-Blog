class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(posts: { author_id: params[:user_id] })
  end

  def show
    @like_state = false
    @post = Post.find(params[:id])
    @post.likes.each do |like|
      @like_state = like.author_id == params[:user_id].to_i
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
        format.html { redirect_to "/users/#{current_user.id}/posts", notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def add_comment
    @new_comment = Comment.new(params.require(:comment).permit(:text))
    @new_comment.author = current_user
    @new_comment.post = Post.find(params[:id])
    respond_to do |format|
      if @new_comment.save
        format.html { redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def add_like
    @new_like = Like.new(author: current_user, post: Post.find(params[:id]))
    respond_to do |format|
      if @new_like.save
        format.html { redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", notice: "Like it!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
