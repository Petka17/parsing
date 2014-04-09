class ProductGroup < ActiveRecord::Base

	belongs_to :subcategory
	has_one :category, through: :subcategory
	has_many :features, dependent: :destroy
	has_many :products, dependent: :destroy

	def self.subcategory_list
		joins(:subcategory, :category)
		.select('subcategory.name as subcategory_name, categories.name as category_name, subcategories.*')
		.order('category_name, name')
	end

	def category_name
		read_attribute("category_name") || category.name
	end

	def subcategory_name
		read_attribute("subcategory_name") || subcategory.name
	end

end
