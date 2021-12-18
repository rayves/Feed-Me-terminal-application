def help
    return "The FEED ME app is a simple app that will take your order and send that information to the kitchen for your order to be prepared."
    puts "Please follow the dialog intructions as you go along until your receipt is printed for your order to to confirmed."
    puts "If you require additional assistance, please ask our friendly staff your help."
end

def intro
    puts "welcome to FEED ME!"
    puts "Please tell me your name so we can start your order."
    print "> "
end



module Menu
    MENU = './data/menu.csv'
    @@menu = CSV.parse(File.read(MENU), headers: true)
    @@food = @@menu.by_col[0]
    @@description = @@menu.by_col[1]
    @@price = @@menu.by_col[2]
    @@ingredients = @@menu.by_col[3]
    @@food_rows = []
    @@food.zip(@@price).each_with_index do |(food, price), index|
        @@food_rows << [index + 1, food, "$#{price}"]
    end
    @@food_table = Terminal::Table.new :headings => ["Item No.", "Name", "Price"], :rows => @@food_rows
    def Menu.display_menu
        return @@food_table
    end
    def Menu.create_customer
        name = gets.chomp
        name = Customer.new(name)
        puts"Welcome #{name.name.capitalize}! what would you like to order?"
        puts "\n"
    end
    def Menu.display_options
        puts "What would you like to do?"
        puts "[1] Order"
        puts "[2] Review Cart"
        puts "[3] Delete Order"
        puts "[4] Help"
        puts "[5] Exit"
    end
    def Menu.selection
        while options = Integer(gets.chomp)
            case
            when 1
                Menu.display_menu
            when 2
            when 3
            when 4
            when 5
            else
                "Invalid Input! Please enter one of the numbers listed in order to proceed"
            end
        end
    end
    def Menu.order
        puts Menu.display_menu
        system("clear")
        if options > 0 && options < @@food.length
            name.order << @@food[options - 1]
            name.order_cost << @@price[options - 1]
        end
    end
end