class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :post

  has_many :favourites, dependent: :destroy
  has_many :favourite_posts, through: :favourites, source: :post

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
