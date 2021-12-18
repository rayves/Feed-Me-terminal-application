class Menu_item
  attr_reader :name, :price, :description, :ingredients

  def initialize(name, description, price, ingredients)
    @name = name
    @description = description
    @price = price
    @ingredients = ingredients
  end
end
  
class Customer
  attr_accessor :name

  def initialize(name)
    @name = name
    @order = []
    @cust_id = rand(0..1000000)
  end
end