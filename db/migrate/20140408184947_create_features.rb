class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.string :value
      t.integer :product_group_id
      t.integer :product_id

      t.timestamps
    end
  end
end
