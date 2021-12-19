# require 'csv'
# require 'terminal-table'

# require_relative './classes'
# require_relative './methods'

# MENU = './data/menu.csv'

# menu = CSV.parse(File.read(MENU), headers: true)
# food = Hash[menu.by_col[0].zip(menu.by_col[2])]
# food_table = []

# food.each_with_index do |(food, price), index|
#     food_table << [index + 1, food, "$#{price}"]
# end

# pp food_table

# index = {hello: 5, firh: 6, ewhrk: 20}

# index2 = index[:hello]

# pp index2

class Customer
    attr_accessor :name, :order
  
    def initialize(name)
      @name = name
      @order = []
      @order_cost = []
      @cust_id = rand(0..1000000)
    end
  
    def welcome_message
      puts"Welcome #{@name.capitalize}! what would you like to do?"
      puts "\n"
    end
  
  end
    
  
  class NoNameError < StandardError
  end
  
  dog = Customer.new("rex")
  
  pp dog.welcome_message