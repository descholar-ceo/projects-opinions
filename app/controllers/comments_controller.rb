class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.opinion_id = params[:opinion_id]
    if @comment.save
      redirect_to opinions_path
    else
      redirect_to opinions_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
