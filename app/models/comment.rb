class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  def self.sort_created
    order('created_at DESC')
  end

end
