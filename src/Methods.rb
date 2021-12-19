def help
    puts "The FEED ME app is a simple app that will take your order and send that information to the kitchen for your order to be prepared."
    puts "Please follow the dialog intructions as you go along until your receipt is printed for your order to to confirmed."
    puts "If you require additional assistance, please ask our friendly staff your help."
end

def intro
    puts "welcome to FEED ME!"
    puts "Please tell me your name so we can start your order."
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
    @@cust_name = ""

    def Menu.display_menu
        puts @@food_table
        puts "\n"
        puts "What would you like to order? Please input the number next to items to make your selection. Otherise if you would like to go back, please enter 'cancel'"
        print "> "
    end

    # def Menu.returning_to_menu
    #     puts "Returning to main menu."
    #     puts "\n"
    #     break
    # end

    def Menu.display_options
        puts "What would you like to do?"
        puts "[1] Order"
        puts "[2] Review Cart"
        puts "[3] Delete Order"
        puts "[4] Help"
        puts "[5] Quit"
        puts "\n"
    end
        
    def Menu.menu
        # system("clear")
        begin
        print "> "
        cust_name = gets.chomp
        if name.empty? || name.nil?
            raise NoNameError
        end
        rescue NoNameError
            puts "Name cannot be empty. Please input your name."
            print "> "
            retry
        rescue
            puts "An Error has occured."
        end
        cust_name = Customer.new(cust_name)
        puts "Welcome #{cust_name.name.capitalize}! what would you like to do?"
        puts "\n"

        Menu.display_options

        print "> "
        while options = gets.chomp.to_i
            case options
            when 1
                system("clear")
                Menu.display_menu
                shopping = false
                while shopping = gets.chomp
                    if shopping.to_i > 0 && shopping.to_i < @@food.length
                        cust_name.order << @@food[shopping.to_i - 1]
                        cust_name.order_cost << @@price[shopping.to_i - 1]
                        puts "#{@@food[shopping.to_i - 1]} has been added to your cart."
                        puts "would you like to order something else?"
                        print "> "
                        shopping_again = false
                        while shopping_again = gets.chomp
                            if shopping_again.downcase == "yes"
                                Menu.display_menu
                                break
                            elsif shopping_again.downcase == "no"
                                puts "Returning to main menu."
                                puts "\n"
                                # shopping = "cancel"
                                break
                            else
                                puts "Invalid Input! Please enter yes or no"
                                puts "\n"
                                puts "would you like to order something else?"
                                print "> "
                            end
                        end
                    elsif shopping.downcase == "cancel"
                        puts "Returning to main menu."
                        puts "\n"
                        break
                    else
                        "Invalid Input. Please Please input the number next to items to make your selection."
                        puts Menu.display_menu
                        print "> "
                    end
                end
            when 2
            when 3
            when 4
                help
            when 5
                Menu.exit
            else
                "Invalid Input! Please enter one of the numbers listed in order to proceed"
                Menu.display_options
                print "> "
            end
        end
    end

    # def Menu.order
    #     system("clear")
    #     puts Menu.display_menu
    #     puts "What would you like to order? Please input the number next to items to make your selection. Otherise if you would like to go back, please enter 'cancel'"
    #     print "> "
    #     shopping = false
    #     while shopping = gets.chomp.to_i
    #         if shopping > 0 && shopping < @@food.length
    #             name.order << @@food[shopping - 1]
    #             name.order_cost << @@price[shopping - 1]
    #             puts "#{@@food[shopping]} has been added to your cart."
    #             break
    #         elsif shopping.downcase == "cancel"
    #             puts "Returning to main menu."
    #             puts "\n"
    #             break
    #         else
    #             "Invalid Input. Please Please input the number next to items to make your selection."
    #             puts Menu.display_menu
    #             print "> "
    #         end
    #     end
    # end

    # def Menu.order_again
    #     system("clear")
    #     puts "would you like to order something else?"
    #     print "> "
    #     shopping_again = false
    #     while shopping_again = gets.chomp
    #         if shopping_again.downcase == "yes"
    #             Menu.order
    #         elsif shopping_again.downcase == "no"
    #             puts "Returning to main menu."
    #             puts "\n"
    #             break
    #         else
    #             puts "Invalid Input! Please enter yes or no"
    #             puts "\n"
    #             puts "would you like to order something else?"
    #             print "> "
    #         end
    #     end
    # end

    def Menu.exit
        puts "Are you sure you want to cancel? (Yes/No)"
        print "> "
        cancel = false
        while cancel = gets.chomp
            if cancel.downcase == "no"
                Menu.display_options
                break
            elsif cancel.downcase == "yes"
                puts "We're sorry to see you go! Please come back if you feel the need for some original food."
                exit!
            else
                puts "Invalid Input! Please enter yes or no"
                print "> "
            end
        end
    end
    
end