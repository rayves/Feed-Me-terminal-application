def help
    puts "The FEED ME app is a simple app that will take your order and send that information to the kitchen for your order to be prepared."
    puts "Please follow the dialog intructions as you go along until your receipt is printed for your order to to confirmed."
    puts "If you require additional assistance, please ask our friendly staff your help."
end

def intro
    puts "welcome to FEED ME!"
    puts "Please tell me your name so we can start your order."
end

def create_list_table(table1, table2)
    table = []
    table1.zip(table2).each_with_index do |(food, price), index|
        table << [index + 1, food, "$#{price}"]
    end
    table_display = Terminal::Table.new :headings => ["Item No.", "Name", "Price"], :rows => table
    puts "\n"
    return table_display
end

def cust_table(cart, order_prices)
    # items_count = table1.tally
    # prices_count = table2.tally
    multiple = cart.values
    items = cart.keys
    prices = order_prices.keys.map(&:to_f)
    prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
    # total_arrray = multiple.zip(items, prices_total)
    table = []
    multiple.zip(items, prices_total).each do |multiple, item, price|
        table << ["#{multiple}x", item, "$#{price.round(2)}"]
    end
    table << :separator
    table << ["", "Total", "$#{prices_total.sum.round(2)}"]
    table_display = Terminal::Table.new :headings => ["Quantitiy", "Name", "Price"], :rows => table
    puts "\n"
    return table_display
end

def invalid_input(message)
    puts "Invalid Input."
    puts message
    puts "\n"
end

def clear
    system("clear")
    puts "\n"
end

def mark
    print "> "
end


module Menu
    #* Module variables used in contained methods
    MENU = './data/menu.csv'
    @@menu = CSV.parse(File.read(MENU), headers: true)
    @@food = @@menu.by_col[0]
    @@description = @@menu.by_col[1]
    @@price = @@menu.by_col[2]
    @@ingredients = @@menu.by_col[3]
    @@food_table = create_list_table(@@food, @@price)
    

    def Menu.display_menu
        puts @@food_table
        puts "\n"
    end

    def Menu.ask_order_select
        puts "Please select the items you would like to add to your cart."
        puts "Input 'cancel' if you would like to return to the main menu."
        puts "\n"
        mark
    end 


    def Menu.display_options
        puts "What would you like to do?"
        puts "[1] Order"
        puts "[2] Review Cart"
        puts "[3] Remove item from order"
        puts "[4] Checkout"
        puts "[5] Help"
        puts "[6] Quit"
        puts "\n"
        mark
    end
    
#* main menu method
    def Menu.menu
        begin
        mark
        #* get customer name for customer class initialization
        cust_name = gets.chomp
        if name.empty? || name.nil?
            raise NoNameError
        end
        rescue NoNameError
            puts "Name cannot be empty. Please input your name."
            mark
            retry
        rescue
            puts "An Error has occured."
        end
        cust_name = Customer.new(cust_name)
        puts "Welcome #{cust_name.name.capitalize}! what would you like to do?"
        puts "\n"

        #* Display menu options for customer selection/navigation
        Menu.display_options

        #* Menu loop [START]
        while options = gets.chomp.to_i

            #* return point for nexted loops
            catch(:end) do
                case options

                #* ORDER ITEM SELECTION
                when 1
                    clear
                    Menu.display_menu
                    #* reset variable if loop reentered
                    info = false
                    puts "Would you like to know more about any of these items? (yes/no)"
                    mark
                    #* Menu [ASK] additional description loop [START]
                    while info = gets.chomp
                        clear
                        Menu.display_menu

                        #* additional desciption option confirmed
                        if info.downcase == "yes"
                            info_section = false
                            mark

                            #* Menu additional description loop [START]
                            while info_section = gets.chomp
                                clear
                                Menu.display_menu
                                puts "Please input the numbers for the item you wish to know more about. when you wish to return, please input 'cancel'"

                                #*if input is within valid number parameters display the corresponding menu item description
                                if info_section.to_i > 0 && info_section.to_i <= @@food.length
                                    puts "\n"
                                    puts @@food[info_section.to_i - 1]
                                    puts "\n"
                                    puts @@description[info_section.to_i - 1]
                                    puts "\n"
                                    mark

                                #* if input is "cancel" return to Menu ASK additional description loop start
                                elsif info_section.downcase == "cancel"
                                    clear
                                    Menu.display_menu
                                    puts "Would you like to know more about any of these items? (yes/no)"
                                    break
                                
                                else
                                    invalid_input("Please Please input the number next to items to make your selection or cancel")
                                    mark
                                end
                            #* Menu additional description loop [END]
                            end

                        #* Additional description option declined
                        elsif info.downcase == "no"
                            puts "Please select the items you would like to add to your cart."
                            puts "Input 'cancel' if you would like to return to the main menu."
                            shopping = false

                            #* Ordering loop [START]
                            while shopping = gets.chomp
                                #*if input is within valid number parameters add item to Customer class order and order_cost hashes
                                if shopping.to_i > 0 && shopping.to_i <= @@food.length

                                    #* if menu item does not exist then create for 1
                                    if !cust_name.order.key?(@@food[shopping.to_i - 1])
                                        cust_name.order[@@food[shopping.to_i - 1]] = 1
                                        cust_name.order_cost[@@price[shopping.to_i - 1]] = 1
                                    
                                    #* if menu item already exists then add 1 to existing item
                                    else
                                        cust_name.order[@@food[shopping.to_i - 1]] += 1
                                        cust_name.order_cost[@@price[shopping.to_i - 1]] += 1
                                    end
                                    puts "#{@@food[shopping.to_i - 1]} has been added to your cart."
                                    pp cust_name.order
                                    pp cust_name.order_cost
                                    puts "Would you like to order something else? (yes/no)"
                                    mark
                                    shopping_again = false

                                    #* [ASK] to add additional items [START]
                                    while shopping_again = gets.chomp

                                        #* if yes then return to Ordering loop [START]
                                        if shopping_again.downcase == "yes"
                                            clear
                                            Menu.display_menu
                                            Menu.ask_order_select
                                            break

                                        #* if no then return to Menu loop [START]
                                        elsif shopping_again.downcase == "no"
                                            puts "Returning to main menu."
                                            puts "\n"
                                            Menu.display_options
                                            throw(:end)

                                        else
                                            puts "Invalid Input! Please enter yes or no"
                                            puts "\n"
                                            puts "would you like to order something else?"
                                            mark
                                        end
                                    #* [ASK] to add additional items [END]
                                    end
                                
                                #* if input = cancels then return to Menu loop [START]
                                elsif shopping.downcase == "cancel"
                                    puts "\n"
                                    puts "Returning to main menu."
                                    puts "\n"
                                    Menu.display_options
                                    throw(:end)
                                    # break
                                else
                                    invalid_input("Please Please input the number next to items to make your selection.")
                                    Menu.display_menu
                                end
                            #* Ordering Loop [END]
                            end
                        else
                            invalid_input("Please input yes or no")
                            puts "\n"
                            puts "Would you like to know more about any of these items? (yes/no)"
                        end
                    #* Menu [ASK] additional description loop [END]
                    end

                #* DISPLAY ORDERS CART OPTION
                when 2
                    puts cust_table(cust_name.order, cust_name.order_cost)
                    Menu.display_options
                
                #* DELETE ITEM FROM ORDER OPTION
                when 3

                #* CHECKOUT OPTION
                when 4
                
                #* HELP OPTION
                when 5
                    help
                
                #* EXIT PROGRAM OPTION
                when 6
                    Menu.exit

                else
                    puts "Invalid Input! Please enter one of the numbers listed in order to proceed"
                    Menu.display_options
                end
            end
        end
    end

    def Menu.exit
        puts "Are you sure you want to cancel? (Yes/No)"
        mark
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
                mark
            end
        end
    end
    
end