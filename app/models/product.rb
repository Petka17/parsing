class Product < ActiveRecord::Base
	belongs_to :product_group
	serialize :params, Hash
end
