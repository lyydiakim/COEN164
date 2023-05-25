require 'erb'

def description
	[
		'Ruby makes your programming more productive',
		'It makes coding fun again',
		'If you are a programmer and want to learn Ruby',
		'This is the book to get',
		'This book will get you up to speed quickly and enjoyably'
	]
end

class ShoppingList
	include ERB::Util
	attr_accessor :template, :title, :author, :descriptionList, :price, :isbn

	def initialize(title, isbn, author, description, price, template)
        @title = title
        @isbn = isbn
        @author = author
		@descriptionList = description
		@price = price
		@template = ""
		i = 0
		File.open("#{template}", "r") do |file|
			file.readlines.each do |line|
				@template += line
				i += 1
			end
		end
	

		filter(@template)
		save('booklistOutput3.html')
	end

	def save(file)
		File.open(file, "w+") do |f|
			f.write(render)
		end
	end

    def render()
		ERB.new(@template).result(binding)
	end

    def filter(input)
		template_str = ""
		(0..(input.length())).each do |a|
			template_str += input[a].to_s
		end
		output_html = File.new("booklistOutput3.html", "w+")
		output_html.puts(template_str)
		output_html.close
	end

	def output(*arg)
		File.open("#{arg[0]}", "r") do |file|
			file.readlines.each do |line|
				puts line
			end
		end
	end

    def add_description(new_description)
        @descriptionList << new_description  
		save('booklistOutput3.html')
    end

end

list = ShoppingList.new("Programming Ruby", "(978-1-93778-549-9)", "Dave Thomas", description, "$50.00", 'booktemplate.html.erb')
list.add_description('added description')
list.output('booklistOutput3.html')
