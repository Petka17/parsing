class CategoryParserWorker < Struct.new(:category_id)
	
	def perform

		job = Delayed::Job.find(@job_id)
		category = Category.find(category_id)

		job.update_attributes(status: "Загрузка подкатегорий", status_code: "sub")
		CategoryLoader.extract_sub(category)

		category.subcategories.order(:name).each do |sub|
			job.update_attributes(status: "Загрузка групп продуктов для подкатегории: #{sub.name}", status_code: "pg")
			CategoryLoader.extract_pg(sub)
		end

		category.product_groups.product_group_list.each do |pg|
			job.update_attributes(status: "Загрузка данных. Подкатегория: #{pg.subcategory_name}. Группа продуктов: #{pg.name}", status_code: "prod")
			CategoryLoader.extract_prod(pg)
		end

		job.update_attributes(status_code: "end")

	end

	def before(job)
    @job_id = job.id
  end 
end