class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :url_path
      t.integer :child_num
      t.integer :category_id

      t.timestamps
    end
  end
end
