class AddIndexToPriceForProducts < ActiveRecord::Migration
  def change
  	add_index :products, :price
  end
end
