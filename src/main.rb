require 'csv'
require 'terminal-table'

require_relative './classes'
require_relative './methods'

#required files


#constant for MENU file for easy reference
MENU = './data/menu.csv'
menu = CSV.parse(File.read(MENU), headers: true)






puts "welcome to FEED ME!"
puts "Please tell me your name so we can start your order."
print "> "
name = gets.chomp
name = Customer.new(name)

puts"Welcome #{name.name.capitalize}! what would you like to order?"
puts "\n"
puts display_menu



# while gets.chomp
#     case 1
