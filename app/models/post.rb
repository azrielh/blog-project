class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true

  has_attached_file :image, :styles => { :medium => "300x300#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user


  def self.search_for(find)
    where("title ILIKE ? OR body ILIKE ?", "%#{find}%", "%#{find}%")
  end

  def self.sort_created
    order('created_at DESC')
  end

end
