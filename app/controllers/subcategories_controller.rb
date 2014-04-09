class SubcategoriesController < ApplicationController

	before_filter :get_subcategory, only: [:show, :extract_pg, :extract_prod]
  def index
  	@subcategories = Subcategory.subcategory_list
  end

  def show
  	@subcategory = Subcategory.find(params[:id])
  	@product_groups = @subcategory.product_groups.order('name')
  end

  def extract_all
  	CategoryLoader.extract_sub_all
  	redirect_to subcategories_path
  end

  def extract_pg
  	CategoryLoader.extract_pg(@subcategory)
  	redirect_to @subcategory
  end

  def extract_prod
    CategoryLoader.extract_sub_prod(@subcategory)
    redirect_to @subcategory
  end

  private

  	def get_subcategory
  		@subcategory = Subcategory.find(params[:id])
  	end

end
