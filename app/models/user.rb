class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :opinions
  has_many :comments

  has_many :followings, foreign_key: :follower_id
  has_many :followeds, through: :followings, source: :followed

  has_many :followers, foreign_key: :followed_id, class_name: :Following
  has_many :my_followers, through: :followers, source: :user
end
