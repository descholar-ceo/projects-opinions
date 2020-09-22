class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.includes(:followings, :followeds, :opinions, :comments, :followers, :my_followers).find(params[:id])
    @opinion = Opinion.new
    @who_to_follow = current_user.who_to_follow(current_user)
  end
end
