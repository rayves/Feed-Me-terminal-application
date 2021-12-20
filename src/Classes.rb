# class Menu_item
#   attr_reader :name, :price, :description, :ingredients

#   def initialize(name, description, price, ingredients)
#     @name = name
#     @description = description
#     @price = price
#     @ingredients = ingredients
#   end
# end
  
class Customer
  attr_accessor :name, :order, :order_cost
  attr_reader :cust_id

  def initialize(name)
    @name = name
    @order = {}
    @order_cost = {}
    @cust_id = rand(0..1000000)
  end

  # def welcome_message
  #   puts"Welcome #{@name.capitalize}! what would you like to do?"
  #   puts "\n"
  # end


end
  

class NoNameError < StandardError
end
