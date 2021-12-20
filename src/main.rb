require 'csv'
require 'terminal-table'
require 'colorize'

require_relative './lib/classes'
require_relative './lib/methods'
require_relative './lib/table_creation'
require_relative './lib/menu'

#required files


#constant for MENU file for easy reference
# MENU = './data/menu.csv'
# menu = CSV.parse(File.read(MENU), headers: true)





#Main Program
if ARGV.length > 0
    flag, *rest = ARGV
    ARGV.clear
    case flag
    when '-help' || '-h'
        help 
        exit!
    when 'show_menu'
        puts Menu.display_menu
        exit!
    else
        puts "Invalid argument,  see README fo valid arguments"
        puts "\n"
        exit!
    end
end

intro
Menu.menu