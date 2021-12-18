require 'csv'
require 'terminal-table'

require_relative './classes'
require_relative './methods'

#required files


#constant for MENU file for easy reference
MENU = './data/menu.csv'
menu = CSV.parse(File.read(MENU), headers: true)




#Main Program
intro
Menu.display_menu
Menu.selection










# while gets.chomp
#     case 1
