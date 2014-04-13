class Category < ActiveRecord::Base

	has_many :subcategories, 	dependent: :destroy
	has_many :product_groups, through: :subcategories
	has_many :features, 			through: :product_groups

	def get_params
		param_hash = {}
		features.order(:name).each { |f| param_hash[f.name] = "" }
		param_hash
	end

end
