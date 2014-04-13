class CategoriesController < ApplicationController
  
  before_filter :get_category, only: [:show, :extract_sub]

  def index
  	@categories = Category.all.order(:name)
  end

  def show
  	@subcategories = @category.subcategories.order(:name)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def extract_all
  	CategoryLoader.extract_cat
  	redirect_to categories_path
  end

  def extract_sub
  	CategoryLoader.extract_sub(@category)
  	redirect_to @category
  end

  def extract_sub_prod
    @job = Delayed::Job.enqueue(CategoryParserWorker.new(params[:id]))
  end

  private

  	def get_category
  		@category = Category.find(params[:id])
  	end
    
end
