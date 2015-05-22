class RemoveImageFileNameFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :image_file_name
    remove_column :posts, :image_content_type
    remove_column :posts, :image_updated_at
    remove_column :posts, :image_file_size
  end
end
