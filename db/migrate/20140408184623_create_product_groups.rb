class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.string :name
      t.string :url_path
      t.integer :child_num
      t.text :description
      t.integer :subcategory_id

      t.timestamps
    end
  end
end
