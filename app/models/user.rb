class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :opinions
  has_many :followings, foreign_key: :follower_id

  has_many :followeds, through: :followings, source: :followed

  def all_my_followers(user)
    Following.where('followed_id=?', user.id)
  end
end
