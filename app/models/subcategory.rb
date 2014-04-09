class Subcategory < ActiveRecord::Base

	belongs_to :category
	has_many :product_groups, dependent: :destroy

	def self.subcategory_list
		joins(:category).select('categories.name as category_name, subcategories.*').order('category_name, name')
	end

	def category_name
		read_attribute("category_name") || category.name
	end
	
end
