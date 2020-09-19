class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :opinions, foreign_key: :author_id
  has_many :comments

  has_many :followings, foreign_key: :follower_id
  has_many :followeds, through: :followings, source: :followed

  has_many :followers, foreign_key: :followed_id, class_name: :Following
  has_many :my_followers, through: :followers, source: :user

  def who_to_follow(logged_in_user)
    found_users = User.all.order('created_at DESC').reject { |curr_user| followeds.include? curr_user }
    found_users.reject { |found| found == logged_in_user }
  end

  def do_i_follow_her?(user)
    followeds.include? user
  end

  def unfollow_this_user(user)
    user_to_unfollow = followings.find_by(followed_id: user.id)
    user_to_unfollow.destroy
  end
end
