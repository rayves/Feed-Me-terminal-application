require 'csv'

require_relative './classes'

#required files


#constant for MENU file for easy reference
MENU = './data/menu.csv'
menu = CSV.parse(File.read(MENU), headers: false)


# menu_food = menu.by_col[0]
# pp menu_food

index = 3

pp menu

# menu_food.each_with_index do |food, index|
#     puts "#{index + 1}. #{food}"
# end

# puts "welcome to FEED ME!"
# puts "Please tell me your name so we can start your order."
# print "> "
# name = gets.chomp
# Customer.new(name)
# Customer.new(name)

# "Welcome #{name}! what would you like to order?"
