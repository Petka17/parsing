class AddIndexToAllTables < ActiveRecord::Migration
  def change
  	add_index :categories, :name, unique: true
  	
  	add_index :subcategories, :name
  	add_index :subcategories, :category_id

  	add_index :product_groups, :subcategory_id
  	add_index :product_groups, :url_path

		add_index :products, :product_group_id
  	add_index :products, :code

  	add_index :features, :name
  	add_index :features, :product_group_id

  end
end
