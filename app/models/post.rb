class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  acts_as_taggable

  has_many :favourites, dependent: :destroy
  has_many :users_who_favourite, through: :favourites, source: :user

  after_initialize :default_count

  mount_uploader :image, ImageUploader

  # has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":style/coffee.jpg"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.search_for(find)
    where("title ILIKE ? OR body ILIKE ?", "%#{find}%", "%#{find}%")
  end

  def self.sort_created
    order('created_at DESC')
  end

  def self.recent_five
    order("created_at DESC").limit(5)
  end

  def self.most_viewed_post
    order("view_count DESC").first
  end

  def increment_view_count
    increment!(:view_count)
  end

  def default_count
    view_count ||= 0
  end

end
