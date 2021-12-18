
class Menu_item
    attr_reader :name, :price, :description
  
    def initialize(name, description, price)
      @name = name
      @description = description
      @price = price
    end
  end
  
  class Customer
    attr_accessor :name
  
    def initialize(name)
      @name = name
      @order = []
    end
  end
  