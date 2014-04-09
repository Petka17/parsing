class AddImgUrlForProductGroups < ActiveRecord::Migration
  def change
  	add_column :product_groups, :img_url, :string
  end
end
