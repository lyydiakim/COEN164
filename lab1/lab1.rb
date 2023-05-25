# Question 1
    # Given a hash of family members, with keys as the title and an array of names as the values, 
    # use Ruby's built-in select method to gather only immediate family members' names into a new array.

    family =
    {       uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
    }

    immediate_family = family.select do |k, v|
        k == :sisters || k == :brothers
    end
        
    arr = immediate_family.values.flatten
        
    p arr


#Question 2
    #2. Given the array:
    words = ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
    'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide', 'flow', 'neon']

    #Write a program that prints out groups of words that are anagrams. Anagrams are words that
    #have the same exact letters in them but in a different order. Your output should look something
    #like this:
    #["demo", "dome", "mode"]
    #["neon", "none"]
    #(etc)

    
    result = {}
    words.each do |word|
        key = word.split('').sort.join
        result[key] ||= []
        result[key] << word
      end

    p result


#Question 3
    #3. Write a method that can take variable length of parameters, and in this method, print out information
    #   about number of parameters, and value of each parameters.

    
    def print_parameters(*params)
        puts "Number of parameters: #{params.length}"
        params.each_with_index do |param, index|
          puts "Parameter #{index+1}: #{param}"
        end
      end
    
      print_parameters("hello",false , [100,20,20],  12)


#Question 4
    # a. to make it more clear, change the above code so that “keyword parameters” are used. also provide the default values for each parameters.
    # b. another advantage of keyword parameters, is you can switch order of the parameter without affecting behavior of the method.
    # try to switch order of the method call and see the result.
    # c. use double splat ** in method definition. a ** argument will be a hash that contain any uncollected keyword parameters passed to the method

    #a  
        def mysterious_total(subtotal:10, tax: 1.04, discount: 3) 
            subtotal + tax - discount
            puts "total : #{subtotal + tax - discount}"
        end

        mysterious_total(subtotal:80, tax:1.04,discount:3)
        mysterious_total()

    #b
    def mysterious_total(subtotal:10, tax: 1.04, discount: 3) 
        subtotal + tax - discount
        puts "total : #{subtotal + tax - discount}"
    end

    mysterious_total(tax:1.04,subtotal:80,discount:3)


    #c

    def mysterious_total(**doublesplat) 
        doublesplat[:subtotal] + doublesplat[:tax] - doublesplat[:discount]
    end

   puts mysterious_total(subtotal:80,tax:1.04,discount:3)


# Question 5
    # 5. Write a class called MyGreeter.
    # This class can initialize a name list, it will have a say_hello method, this method will print
    # “hello” to every name in the name list
    # it will also have a say_bye method, this method will print “bye” to every name in the name list
    
class MyGreeter
    
  def initialize(names)
    @names = names
  end

  def say_hello
    @names.each do |name|
      puts "Hello #{name}"
    end
  end

  def say_bye
    @names.each do |name|
      puts "Bye #{name}"
    end
  end
end

obj = MyGreeter.new(["john", "ken", "ivy", "amy", "wen"])

obj.say_hello
obj.say_bye
    