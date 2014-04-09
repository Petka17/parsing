class ProductGroupsController < ApplicationController

	before_filter :get_product_group, only: [:show, :extract_prod]
  def index
  	@product_groups = ProductGroup.all
  end

  def show
  	@features = @product_group.features.order('name')
  	@products = @product_group.products.order('price')
  end

  def extract_prod
  	CategoryLoader.extract_prod(@product_group)
  	redirect_to @product_group
  end

  private

  	def get_product_group
  		@product_group = ProductGroup.find(params[:id])
  	end

end
