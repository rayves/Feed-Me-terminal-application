require 'csv'
require 'terminal-table'
require 'colorize'
require 'artii'

require_relative './lib/classes'
require_relative './lib/methods'
require_relative './lib/table_creation'
require_relative './lib/menu'





#ARGV
if ARGV.length > 0
    flag, *rest = ARGV
    ARGV.clear
    case flag
    when '-help'
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

#Main Program
clear
intro
Menu.menu