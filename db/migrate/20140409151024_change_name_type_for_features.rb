class ChangeNameTypeForFeatures < ActiveRecord::Migration
  def change
  	change_column :features, :name, :text
  end
end
