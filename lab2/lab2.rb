# Question 1
# As the dojo library is loaded after gym, it has overridden gym's class definition of Push and therefore creates an instance of Push defined in dojo.
# Use modules to solve this problem so that both Push class can be used to create different objects for these two different classes.
puts "Question 1:"
require './gym'  
require './dojo'   

gym_push = Gym::Push.new
puts gym_push.up    # returns 40

dojo_push = Dojo::Push.new
puts dojo_push.up   # rreturns 30

puts gym_push.up    # use this to check the push value

#Question 2
# When you subclass, the instance method will be inherited. However, the "initialize" method 
# in the parent class might not be called automatically if the subclass has "initialize" itself.
# Add a statement to make the Child object be able to initialize the "@name" attribute.

class Parent
  def initialize(name="nobody")
      @name = name
  end
end 

class Child < Parent 
  attr_accessor :name, :grade

  def initialize(name, grade)
      super(name)
      @grade = grade
  end
end

y=Child.new("yuan", 100)

puts "Question 2:"
print "name is: ", y.name
puts 
puts y.grade
y.grade = 90

puts y.grade

#Question 3
# Print all regular constants (other than class/module names), and create an object 
# to call “push()” method to print 15.

puts "Question 3:"
module Dojo 
  A = 4
  module Kata 
      B = 8 
      module Roulette
          class ScopeIn
              def push
                  15
              end
          end
      end
  end
end

A = 16
B = 23
C = 42

puts Dojo::A
puts Dojo::Kata::B
obj = Dojo::Kata::Roulette::ScopeIn.new
puts obj.push()
puts A 
puts B
puts C


# Question 4
puts "Question 4:"
module Greetings
  def english
    puts "Hello!"
  end

  def french
    puts "Bonjour!"
  end

  def spanish
    puts "Hola!"
  end
end

class Hello
  extend Greetings
end


puts Hello.english;
puts Hello.french;
puts Hello.spanish;


# Question 5 
# For each of the following regular expression, give 2 examples of matching string 
# (unless it defines a language that has less then 2 strings), use =~ in IRB to verify the match.
puts "hello my name is lydia, say hello" 
puts "i love you so much, i hate cats"
puts "color, colour"
puts "gray, grey"
puts "babble, bibble"
puts "ggle, google"
puts "google, gooogle"
puts "xxx, axx"
puts "xxxxxxx", "xxxxxxxxxx"
puts "w, W"
puts "a, B, 5, _"
puts "d, D"
puts "1, 9"
puts "12345, 98765"
puts "12.34 , 567"
puts "hello123, hello4567"
puts "shot, shuttle"
puts "ruby on rails, ruby programming"
puts "gem ruby, rails ruby"
puts "ruby"
puts


# Question 6
  puts "Question 6:"
    string = "abc12def34ghi56jkl78mn98op76qrs"

    new_string = string.gsub(/\d/, '-')
    puts new_string

    numbers = string.scan(/\d+/)  # output each number
    puts numbers

    puts numbers.first  # print the first number
   
    string.gsub!(/\D/, "-") # replace all non-digit characters with "-"
    puts string


# Question 7
# Implement the Array#map method and demonstrate it the array [1,2,3,4,5].
class Array
  puts "Question 7:"
    def my_map
      result = []
      self.each do |elem|
        result << yield(elem)
      end
      result
    end
  end

  arr = [1,2,3,4,5]
    new_arr = arr.my_map do |num|
  puts "#{num} - hello"
  num * 3
end

puts new_arr.inspect