class ChangeValueDatatTypeForFeatures < ActiveRecord::Migration
  def change
  	change_column :features, :value, :text
  end
end
