
class Customer
  attr_accessor :name, :order, :order_cost
  attr_reader :cust_id

  def initialize(name)
    @name = name
    @order = {}
    @order_cost = {}
    @cust_id = rand(1000000..9999999)
  end


end
  

class NoNameError < StandardError
end

class NoNumberError < StandardError
end
