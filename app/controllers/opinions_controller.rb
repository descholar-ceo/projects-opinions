class OpinionsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create]

  def index
    @opinions = Opinion.all.order(created_at: :desc)
    @opinion = Opinion.new
    @who_to_follow = current_user.who_to_follow(current_user)
  end

  def create
    @opinion = current_user.opinions.build(opinion_params)

    if @opinion.save
      redirect_to opinions_path, notice: 'Opinion was successfully created.'
    else
      redirect_to opinions_path, alert: 'Sorry! The opinion you submitted failed to be saved please try again!'
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:author_id, :text)
  end
end
