require 'erb'

def shopping_items
  ['milk', 'egg', 'ham', 'bread']
end

def template_file
  File.read("shopping_list_template.html.erb")
end

class ShoppingList
  include ERB::Util
  attr_accessor :items, :template, :date

  def initialize(items, temp, date=Time.now)
    @date =date
    @items = items
    @template = temp
  end

  def render
    erb_object = ERB.new(@template) #erb object has template as attribute 
    erb_object.result(binding) # last evaluated value get returned 
  end

  def output(file)
    File.open(file, "w") do |file|
      file.write(render) #write filter result to the output file 
    end
  end
end

shopping_list = ShoppingList.new(shopping_items, template_file)
shopping_list.output("shopping_list.html")
puts "html file created" 



