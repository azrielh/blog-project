class RenameTagsTableToLabels < ActiveRecord::Migration
  def change
    rename_table :tags, :labels
  end
end
