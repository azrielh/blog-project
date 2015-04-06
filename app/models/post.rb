class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true

  def self.search_for(find)
    where("title ILIKE ? OR body ILIKE ?", "%#{find}%", "%#{find}%")
  end

  def self.sort_created
    order('created_at DESC')
  end

end
