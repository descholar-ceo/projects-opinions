class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @opinion = Opinion.new
    @who_to_follow = current_user.who_to_follow(current_user)
  end
end
