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
        # puts "[3] Remove item from order"
        puts "[3] Checkout"
        puts "[4] Help"
        puts "[5] Quit"
        puts "\n"
        mark
    end
    
#* main menu method
    def Menu.menu
        begin
        mark
        #* get customer name for customer class initialization
        cust_name = gets.chomp
        if cust_name.empty? || cust_name.nil?
            raise NoNameError, "Name cannot be empty. Please input your name."
        end
        rescue NoNameError => e
            clear
            puts e.message
            puts "\n"
            puts "Please tell me your name so we can start your order."
            retry
        rescue
            puts "An Error has occured."
        end
        cust_name = Customer.new(cust_name)
        clear
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
                    info = false
                    puts "Would you like to know more about any of these items? (yes/no)"
                    mark
                    #* Menu [ASK] additional description loop [START]
                    while info = gets.chomp
                        clear
                        Menu.display_menu

                        #* additional desciption option [YES]
                        if info.downcase == "yes"
                            info_section = false
                            puts "Please input the numbers for the item you wish to know more about. when you wish to return, please input 'cancel'"
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
                                    mark
                                    break
                                
                                else
                                    puts "\n"
                                    invalid_input("Please input the number next to items to make your selection or cancel")
                                    mark
                                end
                            #* Menu additional description loop [END]
                            end

                        #* Additional description option [NO]
                        elsif info.downcase == "no"
                            puts "Please select the items you would like to add to your cart."
                            puts "\n"
                            puts "Input 'cancel' if you would like to return to the main menu."
                            mark
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
                                    clear
                                    Menu.display_menu
                                    puts "#{@@food[shopping.to_i - 1]} has been added to your cart.".colorize(:green)
                                    puts "\n"
                                    puts "Would you like to order something else? (yes/no)"
                                    mark
                                    shopping_again = false

                                    #* [ASK] to add additional items [START]
                                    while shopping_again = gets.chomp

                                        #* if [YES] then return to Ordering loop [START]
                                        if shopping_again.downcase == "yes"
                                            clear
                                            Menu.display_menu
                                            Menu.ask_order_select
                                            break

                                        #* if [NO] then return to Menu loop [START]
                                        elsif shopping_again.downcase == "no"
                                            clear
                                            puts "Returning to main menu."
                                            puts "\n"
                                            Menu.display_options
                                            throw(:end)

                                        else
                                            clear
                                            Menu.display_menu
                                            puts invalid_input("Please enter yes or no")
                                            puts "would you like to order something else?"
                                            mark
                                        end
                                    #* [ASK] to add additional items [END]
                                    end
                                
                                #* if input = cancels then return to Menu loop [START]
                                elsif shopping.downcase == "cancel"
                                    clear
                                    puts "Returning to main menu."
                                    puts "\n"
                                    Menu.display_options
                                    throw(:end)
                                    # break
                                else
                                    clear
                                    Menu.display_menu
                                    invalid_input("Please Please input the number next to items to make your selection.")
                                    mark
                                end
                            #* Ordering Loop [END]
                            end
                        else
                            clear
                            Menu.display_menu
                            invalid_input("Please input yes or no")
                            puts "Would you like to know more about any of these items? (yes/no)"
                            mark
                        end
                    #* Menu [ASK] additional description loop [END]
                    end

                #* DISPLAY ORDERS CART OPTION
                when 2
                    clear
                    if cust_name.order.length > 0
                        puts cust_table(cust_name.order, cust_name.order_cost)
                        puts "\n"
                        Menu.display_options
                    else
                        puts "Your cart if empty."
                        puts "\n"
                        Menu.display_options
                    end

                
                # #* DELETE ITEM FROM ORDER OPTION
                # when 3
                #     clear
                #     puts cust_table(cust_name.order, cust_name.order_cost)
                #     puts "Please select the item you wish to delete by entering its name."
                #     mark
                #     while deleting = gets.chomp
                #         if cust_name.order.key?(deleting.split(/ |\_/).map(&:capitalize).join(" "))
                #             cust_name.order[deleting.split(/ |\_/).map(&:capitalize).join(" ")] -= 1
                #             pp cust_name.order
                #             pp cust_name.order_cost
                #         elsif !cust_name.order.key?(deleting.downcase.capitalize) && @@food.include?(deleting.downcase.capitalize)
                #             clear
                #             puts cust_table(cust_name.order, cust_name.order_cost)
                #             puts "You do not have this item in your cart"
                #             puts "\n"
                #             puts "Please select the item you wish to delete by entering its name."
                #             mark
                #         else
                #             invalid_input("Please select the item you wish to delete by entering its name")
                #         end
                #     end


                #* CHECKOUT OPTION
                when 3
                    clear
                    #* If cart [IS NOT] empty then proceed
                    if cust_name.order.length > 0
                    puts "Your order is confirmed.".colorize(:green)
                    puts "\n"
                    puts "You will now proceed to the payment section."
                    puts "\n"
                    puts "Please enter any promotional discount code or employee discount code. Otherwise enter 'no'"
                    puts "\n"
                    mark
                        #* Discount coupon loop [START]
                        while promo_code = gets.chomp
                            if promo_code.downcase == "employee discount"
                                clear
                                discount = 0.15
                                puts "Your employee discount of 15% off final order has been added to your order.".colorize(:green)
                                puts "\n"
                                break
                            elsif promo_code.downcase == "save the kids"
                                clear
                                discount = 0.10
                                puts "Save the Kids promotional discount of 10% off final order has been added to your order.".colorize(:green)
                                puts "\n"
                                break
                            elsif promo_code.downcase == "no"
                                clear
                                discount = 0
                                puts "Proceeding to payment.".colorize(:green)
                                puts "\n"
                                break
                            else
                                clear
                                invalid_input("Please only enter the promotional discount code, employee discount code, or no.")
                                mark
                            end
                        #* Discount coupon loop [END]
                        end

                    #* If cart [IS] empty then return to Menu loop [START]
                    else
                        clear
                        puts "Your cart is empty."
                        puts "\n"
                        puts "Please select items to add to your cart by navigating through the Order selection before you can checkout."
                        puts "\n"
                        Menu.display_options
                    end
                    if cust_name.order.length > 0
                        puts checkout_table(cust_name.order, cust_name.order_cost, cust_name.cust_id, discount)
                        puts "\n"
                        puts "Please see your confirmed order above."
                        puts "\n"
                        puts "Please enter an amount you wish to pay."
                        begin
                        mark
                        while payment = gets.chomp.to_f
                            grand_total = calculate_grand_total(cust_name.order, cust_name.order_cost, discount)
                            if payment == grand_total
                                clear
                                puts "Payment confirmed.".colorize(:green)
                                break
                            elsif payment > grand_total
                                clear
                                puts "Payment confirmed.".colorize(:green)
                                puts "\n"
                                puts "Your change is $#{(payment - grand_total).round(2)}."
                                break
                            elsif payment < grand_total && payment > 0
                                clear
                                puts checkout_table(cust_name.order, cust_name.order_cost, cust_name.cust_id, discount)
                                puts "\n"
                                puts "Insufficient funds.".colorize(:red)
                                puts "\n"
                                puts "Please input an amount greater than or equal to the Grand Total of your order."
                                mark
                            elsif payment == 0 || payment == 0.0
                                raise NoNumberError, "Amount must be a number and cannot be 0"
                            else
                                clear
                                puts checkout_table(cust_name.order, cust_name.order_cost, cust_name.cust_id, discount)
                                puts "\n"
                                invalid_input("Please enter an amount you wish to pay.")
                                mark
                            end
                        end
                        rescue NoNumberError => e
                            clear
                            puts checkout_table(cust_name.order, cust_name.order_cost, cust_name.cust_id, discount)
                            puts "\n"
                            puts e.message.colorize(:red)
                            puts "\n"
                            puts "Please enter an amount you wish to pay."
                            retry
                        rescue
                            clear
                            puts checkout_table(cust_name.order, cust_name.order_cost, cust_name.cust_id, discount)
                            puts "\n"
                            puts "An Error has occurred.".colorize(:red)
                            puts "\n"
                            puts "Please wait for a staff member to come to your assistance".colorize(:blue)
                            exit!
                        end
                        puts "\n"
                        puts receipt(cust_name.order, cust_name.order_cost, cust_name.cust_id, cust_name.name, discount, payment)
                        puts "\n"
                        Menu.ordered_message
                    end
                
                #* HELP OPTION
                when 4
                    clear
                    help
                    Menu.display_options
                
                #* EXIT PROGRAM OPTION
                when 5
                    clear
                    Menu.exit

                else
                    clear
                    invalid_input("Please enter one of the numbers listed in order to proceed.")
                    Menu.display_options
                end
            end
        end
    end

    def Menu.exit
        puts "Are you sure you want to cancel? (Yes/No)"
        puts "\n"
        mark
        cancel = false
        while cancel = gets.chomp
            if cancel.downcase == "no"
                clear
                Menu.display_options
                break
            elsif cancel.downcase == "yes"
                clear
                puts title
                puts "We're sorry to see you go! Please come back if you feel the need for some original food."
                puts "\n"
                exit!
            else
                clear
                puts invalid_input("Please enter yes or no")
                puts "Are you sure you want to cancel? (Yes/No)"
                mark
            end
        end
    end

    def Menu.ordered_message
        puts "Your order is being processed.".colorize(:green)
        puts "\n"
        puts "Please take this receipt while your order is being prepared."
        puts "\n"
        puts "Thank you for choosing us to full your belly."
        puts "\n"
        puts "We hope you enjoy your meal and have a good day."
        puts "\n"
        exit!
    end
    
end