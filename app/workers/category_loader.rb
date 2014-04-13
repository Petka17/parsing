class CategoryLoader

	def self.extract_cat
		
		Category.delete_all

		url = "http://www.isolux.ru/"
		page = Nokogiri::HTML(open(url), nil, 'UTF-8')

		category_list 	= page.css('ul#catalog-menu a')

		category_list.each do |c|

			name = c.content.squish
			url_path = c['href'].squish

			Category.create(name: name, url_path: url_path)

		end
	
	end

	def self.extract_sub(category)
		
		category.subcategories.delete_all

		url = category.url_path
		page = Nokogiri::HTML(open(url), nil, 'UTF-8')

		subcategory_list 	= page.css('.categoryNavig a')

		subcategory_list.each do |s|

			name = s.content.squish
			url_path = s['href'].squish

			category.subcategories.create(name: name, url_path: url_path)

		end

		category.update_attribute(:child_num, subcategory_list.size)
	
	end

	def self.extract_sub_all
		Category.all.each do |cat|
			CategoryLoader.extract_sub(cat)
		end
	end

	def self.extract_pg(subcategory, job = nil)

		subcategory.product_groups.delete_all

		url = subcategory.url_path
		pg_num = 0

		begin

			page = Nokogiri::HTML(open(url), nil, 'UTF-8')
			product_group_list 	= page.css('.products-grid .item h2 a')

			product_group_list.each do |s|

				name = s['title'].squish
				url_path = s['href'].squish

				subcategory.product_groups.create(name: name, url_path: url_path)

			end
			
			pg_num += product_group_list.size

			next_page = page.css('a.next')[0]
			url = next_page.nil? ? nil : next_page['href']

		end until url.nil?

		subcategory.update_attribute(:child_num, pg_num)
	
	end

	def self.extract_prod(product_group)

		product_group.features.delete_all
		product_group.products.delete_all

		url = product_group.url_path
		page = Nokogiri::HTML(open(url), nil, 'UTF-8')

		features_name_list 	= page.css('th.label')
		features_value_list = page.css('td.data')

		features_name_list.zip(features_value_list).each do |n, v|

			name = n.content.squish
			value = v.content.squish
			
			product_group.features.create(name: name, value: value)

		end

		first_row = page.css('#super-product-table th')
		product_data = page.css('#super-product-table tbody tr')

		product_data.each do |row|
			
			main_params = {}
			params = {}

			row.css('td').zip(first_row).each do |r, f|
				
				elem_class = f["class"].nil? ? nil : f["class"].split(" ").last
				elem_caption = f.content.squish

				unless elem_class.nil?
					main_params[elem_class] = r.content.squish
				else
					params[elem_caption] = r.content.squish
				end

			end

			prod_name = main_params["cell_name"] || product_group.name
			prod_code = main_params["al"]
			prod_price = row.css('.cost3 .regular-price .price').text.gsub(/\D/, '').to_f / 100

			product_group.products.create(name: prod_name, code: prod_code, price: prod_price, params: params)

		end

		img_url = page.css('.lupa.gallery_elements')[0]["href"]

		desc = page.css('#full-description')
		desc[0]["style"] = ""

		product_group.update_attributes(child_num: product_data.size, description: desc.to_s, img_url: img_url)
	
	end

	def self.extract_sub_prod(subcategory)
		subcategory.product_groups.each do |pg|
			CategoryLoader.extract_prod(pg)
		end		
	end


	def self.extract_cat_sub_prod(category)
		category.subcategories.each do |sub|
			extract_pg(sub)
			extract_sub_prod(sub)
		end
	end
	
end