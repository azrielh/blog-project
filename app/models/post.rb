class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :tags, dependent: :destroy
  has_many :categories, through: :tags

  has_many :favourites, dependent: :destroy
  has_many :users_who_favourite, through: :favourites, source: :user


  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":style/blog-default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.search_for(find)
    where("title ILIKE ? OR body ILIKE ?", "%#{find}%", "%#{find}%")
  end

  def self.sort_created
    order('created_at DESC')
  end

  def increment_view_count
    increment!(:view_count)
  end

end
