def help
    puts "The FEED ME app is a simple app that will take your order and send that information to the kitchen for your order to be prepared."
    puts "\n"
    puts "Please follow the dialog intructions as you go along until your receipt is printed for your order to to confirmed."
    puts "\n"
    puts "If you require additional assistance, please ask our friendly staff your help."
    puts "\n"
end

def title
    artii = Artii::Base.new font: 'big'
    return artii.asciify("FEED ME!").colorize(:red)
end

def intro
    artii = Artii::Base.new font: 'big'
    puts artii.asciify("Welcome to").colorize(:light_red)
    puts title
    puts "Please tell me your name so we can start your order."
    # puts "Please tell me your name so we can start your order."
end

def calculate_grand_total(cart, order_prices, discount)
    multiple = cart.values
    items = cart.keys
    prices = order_prices.keys.map(&:to_f)
    prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
    order_sum = prices_total.sum.round(2)
    discount_amount = (order_sum * discount).round(2)
    order_total = (order_sum - discount_amount).round(2)
    return order_total
end


def invalid_input(message)
    puts "Invalid Input.".colorize(:red)
    puts "\n"
    puts message.colorize(:light_blue)
    puts "\n"
end

def clear
    system("clear")
    puts "\n"
end

def mark
    print "> "
end

