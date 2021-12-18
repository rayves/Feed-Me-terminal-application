require_relative './classes'

require './data/menu.json'

 


puts "welcome to FEED ME!"
puts "Please tell me your name so we can start your order."
print "> "
name = gets.chomp
Customer.new(name)