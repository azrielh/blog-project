class Category < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :tags, dependent: :destroy
  has_many :posts, through: :tags

end
