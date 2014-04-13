class Product < ActiveRecord::Base
	
	belongs_to 	:product_group
	has_one 		:subcategory, through: :product_group
	has_one 		:category, 		through: :subcategory
	has_many		:features, 		through: :product_group

	serialize :params, Hash

	def self.product_list
		joins(:product_group, :subcategory, :category)
		.select('product_groups.description as description, product_groups.img_url as img_url, product_groups.url_path as url_path, subcategories.name as subcategory_name, categories.name as category_name, product_groups.*')
		.order('category_name, subcategory_name, name')
	end

	def description
		read_attribute("description") || product_group.description
	end
	
	def img_url
		read_attribute("img_url") || product_group.img_url
	end

	def url_path
		read_attribute("url_path") || product_group.url_path
	end

	def category_name
		read_attribute("category_name") || category.name
	end

	def subcategory_name
		read_attribute("subcategory_name") || subcategory.name
	end

	def full_name
		fn = self.name
		params.each { |key, value| fn = fn + " " + key + " " + value }
		fn
	end

	def get_params
		param_hash = {}
		features.each { |f| param_hash[f.name] = f.value }
		param_hash
	end

	def get_all_params(tmpl)
		get_params.each { |key, value| tmpl[key] = value }
		tmpl
	end

end
