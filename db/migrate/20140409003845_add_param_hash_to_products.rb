class AddParamHashToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :params, :text
  end
end
