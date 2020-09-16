class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @all_my_followers = User.all_my_followers(user)
  end
end
