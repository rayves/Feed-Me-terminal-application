require 'csv'
require 'terminal-table'

require_relative './classes'
require_relative './methods'

MENU = './data/menu.csv'
menu = CSV.parse(File.read(MENU), headers: true)
food = menu.by_col[0]
description = menu.by_col[1]
price = menu.by_col[2]
ingredients = menu.by_col[3]
food_table = create_list_table(food, price)

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
    attr_accessor :name, :order, :order_cost
  
    def initialize(name)
      @name = name
      @order = []
      @order_cost = []
      @cust_id = rand(0..1000000)
    end
  
    # def welcome_message
    #   puts"Welcome #{@name.capitalize}! what would you like to do?"
    #   puts "\n"
    # end
  
    def display_order
        order_total_items = @order.tally.keys
        order_total_prices = @order_cost.tally
        multiple = order_total_prices.values
        items = order_total_items.keys
        prices = order_total_prices.keys.map(&:to_f)
        prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
        total_arrray = multiple.zip(items, prices_total)
        
        pp order_total_items
        # pp items
        # pp multiple
        # pp prices
        # pp prices_total
        # pp total_arrray
    end
  
end
    
  
  class NoNameError < StandardError
  end
  
  ray = Customer.new("Ray")

  ray.order << food[0]
  ray.order_cost << price[0]
  ray.order << food[0]
  ray.order_cost << price[0]
  ray.order << food[0]
  ray.order_cost << price[0]
  ray.order << food[2]
  ray.order_cost << price[2]
  ray.order << food[4]
  ray.order_cost << price[4]
  

  
  ray.display_order