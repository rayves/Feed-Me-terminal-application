def help
    return "The FEED ME app is a simple app that will take your order and send that information to the kitchen for your order to be prepared."
    puts "Please follow the dialog intructions as you go along until your receipt is printed for your order to to confirmed."
    puts "If you require additional assistance, please ask our friendly staff your help."
end

def intro
    puts welcome to "FEED ME!"
end

def display_menu
    menu = CSV.parse(File.read(MENU), headers: true)
    food = menu.by_col[0]
    food.each_with_index do |food, index|
        puts "#{index + 1}. #{food}"
    end
end