class CategoriesController < ApplicationController
  
  before_filter :get_category, only: [:show, :extract_sub]

  def index
  	@categories = Category.all.order(:name)
  end

  def show
  	@subcategories = @category.subcategories.order(:name)
  end

  def extract_all
  	CategoryLoader.extract_cat
  	redirect_to categories_path
  end

  def extract_sub
  	CategoryLoader.extract_sub(@category)
  	redirect_to @category
  end

  private
  	def get_category
  		@category = Category.find(params[:id])
  	end
end
