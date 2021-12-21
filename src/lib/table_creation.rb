
def create_list_table(menu_items, prices)
    table = []
    menu_items.zip(prices).each_with_index do |(food, price), index|
        table << [index + 1, food, "$#{price}"]
    end
    table_display = Terminal::Table.new :headings => ["Item No.", "Name", "Price"], :rows => table
    return table_display
end

def cust_table(cart, order_prices)
    multiple = cart.values
    items = cart.keys
    prices = order_prices.keys.map(&:to_f)
    prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
    table = []
    multiple.zip(items, prices_total).each do |multiple, item, price|
        table << ["#{multiple}x", item, "$#{price.round(2)}"]
    end
    table << :separator
    table << ["", "Total", "$#{prices_total.sum.round(2)}"]
    table_display = Terminal::Table.new :headings => ["Quantity", "Name", "Price"], :rows => table
    return table_display
end

def checkout_table(cart, order_prices, cust_id, discount)
    multiple = cart.values
    items = cart.keys
    prices = order_prices.keys.map(&:to_f)
    prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
    order_sum = prices_total.sum.round(2)
    discount_amount = (order_sum * discount).round(2)
    order_total = (order_sum - discount_amount).round(2)
    
    table = []
    multiple.zip(items, prices_total).each do |multiple, item, price|
        table << ["#{multiple}x", item, "$#{price.round(2)}"]
    end

    table << :separator
    table << ["", "Total", "$#{order_sum}"]
    table << ["", "Discount", "-$#{discount_amount}"]
    table << :separator
    table << ["", "Grand Total", "$#{order_total}"]

    table_display = Terminal::Table.new :title => "Order No. #{cust_id}", :headings => ["Quantity", "Items", "Price"], :rows => table
    return table_display
end

def receipt(cart, order_prices, cust_id, cust_name, discount, payment)
    artii = Artii::Base.new font: 'big'
    multiple = cart.values
    items = cart.keys
    prices = order_prices.keys.map(&:to_f)
    prices_total = prices.zip(multiple).map{|x,y| (x * y).round(2)}
    order_sum = prices_total.sum.round(2)
    discount_amount = (order_sum * discount).round(2)
    order_total = (order_sum - discount_amount).round(2)
    change = (payment - order_total).round(2)
    
    table = []
    multiple.zip(items, prices_total).each do |multiple, item, price|
        table << ["#{multiple}x", item, "$#{price.round(2)}"]
    end

    table << :separator
    table << ["", "Total", "$#{order_sum}"]
    table << ["", "Discount", "-$#{discount_amount}"]
    table << :separator
    table << ["", "Grand Total", "$#{order_total}"]
    table << ["", "Payment", "-$#{payment}"]
    table << :separator
    table << ["", "Change", "$#{change}"]

    table_display = Terminal::Table.new :title => "Order No. #{cust_id}", :headings => ["Quantity", "Items", "Price"], :rows => table

    File.open("./output/Receipt No. #{cust_id}.txt", 'w+') do |file|
        file.write(
            artii.asciify("FEED ME!"),
            "\n",
            table_display,
            "\n",
            "\n",
            "Thanks for ordering with us #{cust_name.capitalize}!"
        )
    end

    puts artii.asciify("FEED ME!").colorize(:light_red)
    return table_display
end
    