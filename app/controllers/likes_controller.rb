class LikesController < ApplicationController
  def add_like
    @new_like = Like.new(author: current_user, post: Post.find(params[:id]))
    respond_to do |format|
      if @new_like.save
        format.html { redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", notice: 'Like it!' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
