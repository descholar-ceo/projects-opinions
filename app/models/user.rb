class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,
            uniqueness: true,
            length: { in: 3..15 }

  validates :email, presence: true, uniqueness: true, length: { in: 3..50 }, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :password, presence: true, length: { in: 6..20 }
  validates :full_name, presence: true, length: { in: 3..50 }

  has_many :opinions, foreign_key: :author_id
  has_many :comments

  has_many :followings, foreign_key: :follower_id
  has_many :followeds, through: :followings, source: :followed

  has_many :followers, foreign_key: :followed_id, class_name: :Following
  has_many :my_followers, through: :followers, source: :user

  def who_to_follow(logged_in_user)
    found_users = User.includes(:followers, :my_followers, :followings, :followeds).all.order(created_at: :desc).reject do |curr_user|
      followeds.include? curr_user
    end
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
