class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(body: params[:comment][:body], opinion_id: params[:opinion_id])
    puts "Created comment instance is #{@comment} and params are #{params}"
    if @comment.save
      redirect_to opinions_path
    else
      redirect_to opinions_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  def comment_params
    params.require(:comment).permit(:opinion_id, :body)
  end
end
