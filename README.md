# Feed Me Terminal Application

# Links
## Github Repository Link

[Github Repository](https://github.com/rayves/Feed-Me-terminal-application)
## Purpose

### High Level Description 
The Feed Me! Terminal Application is an easy-to-use point-of-sale program for the fictional fast-food restaurant “Feed Me!”. The program will allow users to see the completely original menu for the restaurant and select the items they would like to order. All that needs to be done is for the customer to input their name, add their items to the virtual cart and confirm with payment. The result will be a receipt with their order, then the program can restart for the next customer.

### Why is this app being developed?
The Feed Me app is the starting point for a point of service terminal app project that will keep on evolving and could someday be used for back-end purposes for machine point of sale applications or online markets.

### Target Audience
FEED ME is aimed at anyone that wants an easy-to-use point of sale app that gets straight to the point and gives them what they need.

Having a simple interface and being easy to use, the app hopes to be accessibility to everyone, meeting their specific needs. Currently the app’s base features show that the app is operational and will complete its purpose in compiling orders selected and fulfilling those orders by way of a receipt with the order’s complete details. However, the app currently lacks quality of life functions such as:

- Ability to remove items from the cart;
- Ability to customise menu items; and 
- Accessibility for the visually impaired. 

These features are currently planned, and development and implementation will occur in an update sometime in the future or when the technology becomes available.

### How user can use this app
Customers can use the app by navigating through a simple interface which will display menu options to other features within the app. Customers can add FEED ME!’s menu items one by one and when they are ready proceed to payment, they will be prompted with the option to input a discount code which will be applied to their final order. Finally, they will be prompted to add a payment amount which if confirmed will process their payment and print a receipt with their customer number, order details and a message thanking them personally.

## Features & User interaction

1. Customer name input 
   
For a personalized experience the program will ask for the users name which will be displayed with a welcome message if the name if confirmed.

   1. Upon starting the application the program will request the users name and the user must enter any name to continue.
   2. if no name is enter an error will be raised requesting a name in order to continue.

1. Menu Options

    Displays menu options to navigate between the various features.

    1. If 1 is selected the user will enter the Ordering Feature.
    2. If 2 is selected a table with the users 'cart' will display - showing the current items selected for order.
       1. if there are no items in the 'cart'. Message "Cart is empty will display"
    3. If 3 is selected a the user will enter the Checkout feature
       1. if there are no items in the 'cart'. Message "cart is empty will display" and prompt user to start ordering and add items to the cart in order to proceed.
    4. If 4 is selected a help message will display advising the user how the app works.
    5. If 5 is selected quit feature will begin.

2. Database Menu Items Display

Displays menu items for the user to choose from and add to their order.

   1. The program imports in a csv with the name, description, price, and ingredients, and stores this information in an array waiting to be manipulated.
   2. The name, description and prices will then be displayed in a user friendly way in a table using the [Terminal Table](https://github.com/tj/terminal-table/) Ruby gem.

3. Display further description of menu
   
   This feature displays a description of each of the menu items that is selected by the user.

   1. Users once selecting that they want to start ordering will be prompted with a question asking if they would like to read further details on each of the menu items - describing the item with an overview of the ingredients.
   2. if 'yes' then they can input the numbers next to the items for a brief explanation of each.
   3. Once done they can input 'cancel' to return to the ordering menu where they will be prompted the same question whether they would like to read further details on each menu item
   4. if anything other than the above is entered an invalid input message will be display, then advising the correct input.

4. Customer order selection 

5. Customer item removal 

6. Orders Database 

7.  Payment by way of input 

8. reduction in price with Special input 

9.  Display total order with items 

10. Output final order with unique customer I.D. to file 
 
## User Interaction and Experience
- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user

## Control Flow Diagram
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.

## Implementation Plan



Tracking of the implementation plan has been done through [Trello](https://trello.com/b/ahY5LGQu/feed-me-fast-food-app).

# Utilization and Install Instructions
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements

# Usage

## Program Execution

Option 1: Run the main file via terminal either by executing the file's entire PATH from root or from the `Feed-Me-terminal-application/src directory` directory

    $ ruby main.rb

Option 2: Run the bash script file from the terminal either by inputing its entire PATH from your devices root, or by navigating to the `Feed-Me-terminal-application/src directory` and executing the below command.

    $ ./feed_me.sh

## Discount code

Within the program when prompted to input a promotional discount code or an employee discount code, the below inputs are the only valid inputs for a discount code.

### Promotional Discount Code

    $ save the kids

### Employee Discount Code

    $ employee discount

# Dependencies

The dependencies are bundled within the bundle file which is generated using the [Bundle](https://github.com/rubygems/bundler) gem. Please install bundler if not already installed for the below commands to execute properly.

 From the `Feed-Me-terminal-application/src` directory execute the below command within the terminal to install bundle gem dependencies. 

    $ bundle install

Required Gemlist:
- [colorize](https://github.com/fazibear/colorize)
- [terminal-table](https://github.com/tj/terminal-table)
- [rspec](https://github.com/rspec/rspec-core)
- [artii](https://github.com/miketierney/artii)
- [CSV](https://github.com/ruby/csv)