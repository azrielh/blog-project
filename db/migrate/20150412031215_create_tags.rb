class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :category, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
