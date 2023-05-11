class CommentsController < ApplicationController
  def add_comment
    @new_comment = Comment.new(params.require(:comment).permit(:text))
    @new_comment.author = current_user
    @new_comment.post = Post.find(params[:id])
    respond_to do |format|
      if @new_comment.save
        format.html do
          redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}",
                      notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
