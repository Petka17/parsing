class ProductGroup < ActiveRecord::Base

	belongs_to :subcategory
	has_one :category, through: :subcategory
	has_many :features, dependent: :destroy
	has_many :products, dependent: :destroy

	def self.product_group_list
		joins(:subcategory, :category)
		.select('subcategories.name as subcategory_name, categories.name as category_name, product_groups.*')
		.order('category_name, subcategory_name, name')
	end

	def category_name
		read_attribute("category_name") || category.name
	end

	def subcategory_name
		read_attribute("subcategory_name") || subcategory.name
	end

end
