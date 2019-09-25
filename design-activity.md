What classes does each implementation include? 
 * Both implementation A and B have the following classes: 
   * CartEntry
   * Shopping Cart
   * Order

Write down a sentence to describe each class: 
 * Implementation A: 
   * CartEntry: Instances of CartEntry are used to wed unit prices and quantity for an entry. 
   * Shopping Cart: Instances of ShoppingCart are used to store entries.
   * Order: Instances of Order are used to create new instances of ShoppingCart, and can also calculate the total price for the contents of the cart. 
 * Implementation B: 
   * CartEntry: Instances of CartEntry are used to wed unit prices and quantity for an entry, it also knows the price for a given grouping of items like how much "carrots" would cost using their quantity and unit price. 
   * Shopping Cart: Instances of ShoppingCart are used to store entires and can determine the subtotal price (without tax) for the current cart contents 
   * Order: Instances of Order are used to create new instances of ShoppingCart and can calculate the total price by accessing the subtotal price from the aforementioned ShoppingCart. 

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
 * Cart entry has a many-to-one relationship with ShoppingCart. Order and ShoppingCart have a one-to-one relationship. 

What data does each class store?
 * Instances of CartEntry store their individual unit prices and quantities
 * Instances of ShoppingCart store entries, which I believe are instances of CartEntry
 * Order does not store anything

How (if at all) does this differ between the two implementations?
 * These are the same between Implementation A and B. 

What methods does each class have? How (if at all) does this differ between the two implementations?
 * Implementation A: 
   * CartEntry has an initialize method which creates instances of itself. Other classes may access the unit price and quantity of each instance. 
   * ShoppingCart has an initialize method in which it creates an array to hold entries.This array may be accessed by other classes. 
   * Order has an initialize method in which it creates new instances of ShoppingCart. It also has a total_price method in which it calculates the total cost of the cart by accessing the ShoppingCart's entry array and within that each entry's unit price and quantity. 
 * Implementation B: 
   * CartEntry has an initialize method which creates instances of itself. However, as it does not have an attr_reader, it can only return the price of the items in the entry as a whole. 
   * ShoppingCart has an initialize method in which it creates an array to hold entries. However, as it does not have an attr_reader, it relies on a price method to return the subtotal price for all the items in the cart. It does this by accessing the entry's price method from CartEntry class. 
   * Order has an initialize method in which it creates new instances of ShoppingCart. In addition, it has a total_price method in which it calculates the total cost of the cart using the ShoppingCart's price method and the sales tax which Order stores as a constant. 

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
 * Implementation A: The price computation is retained in Order.
 * Implementation B: The price computation is delegated to lower level classes.

Does total_price directly manipulate the instance variables of other classes?
 * Implementation A: Yes. It accesses individual CartEntries stored in ShoppingCart individually to calculate the total price. 
 * Implementation B: No. It only calls the price method in ShoppingCart class. 

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
* It depends on what "in bulk" means: 
  * It could be a single item that's literally a bigger size but might still be a single entry, in which case it would change nothing.
  * If, instead, it meant buying lots of small items that are identical such as a dozen cans of tomatoes rather an a single can and these items would be considered a single entry, it would change only the quantity in CartEntry. This would have virtually no consequences in either Implementation. 
  * If, however, it meant that each of the cans of tomatoes would be considered its own entry, that would have the following consequences: 
    * Implementation A: Due to Order digging through ShoppingCart for individual CartEntries, I imagine this might slow down total_price calculation. 
    * Implementation B: Due to the price calculation being embedded in ShoppingCart, I don't think this would change anything. 

  * I don't think the code needs to be changed at this point, because how instances of  CartEntry isn't described, and therefore, this might already be accounted for in "quantity". Nevertheless, Implementation B is easier to modify.  


Which implementation better adheres to the single responsibility principle?
  * Implementation B.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  * Implementation B has less dependencies and the movement of information within its classes is more controlled.
//

Revisiting Hotel
* The refactor.txt part of the assignment was missed at the time of the original submission. Therefore, as I reassess the classes in Hotel, I am amassing the following refactoring ideas. 

Booker: 
* What is this class's responsibility?
  * (Booker does too much) It populates the hotel by creating instances of rooms, it instigates reservations, it instigates soft reservations aka blocks, it lists the rooms available for a given date range, it selects the room for a reservation, it transforms soft reservations (blocks) into actual reservations, it validates incoming data. 
* Is this class responsible for exactly one thing?
  * Lol, no, it's responsible for loads of things. 
* Does this class take on any responsibility that should be delegated to "lower level" classes?
  * Yes. Tons! 
* Is there code in other classes that directly manipulates this class's instance variables?
  * No, no one reaches into Booker, but it's too closely dependent on Reservations and Blocks specifically so I worry about detangling them. 

Room: 
* What is this class's responsibility?
  * Room presents its ID and base cost. 
* Is this class responsible for exactly one thing?
  * Yes
* Does this class take on any responsibility that should be delegated to "lower level" classes?
  * There are no lower classes. 
* Is there code in other classes that directly manipulates this class's instance variables?
  * Yes, I think that cost being an instance variable is a mistake, a redundancy, because it has a class method (self.cost) to access its base cost already. 

Reservation: 
* What is this class's responsibility?
  * Reservation holds instance-specific information for each reservation which includes the calculation of the cost of the reservation.
* Is this class responsible for exactly one thing?
  * No. It adapts for a possible block discount when calculating the cost. 
* Does this class take on any responsibility that should be delegated to "lower level" classes?
  * There are no lower level classes, but I feel that its functions could be broken down into smaller, single-responsibility methods. 
* Is there code in other classes that directly manipulates this class's instance variables?
  * I fear that this might be the case, because all of the instance variables are accessible. 

Block: 
* What is this class's responsibility?
  * Block creates instances of itself.
* Is this class responsible for exactly one thing?
  * Yes
* Does this class take on any responsibility that should be delegated to "lower level" classes?
  * No.
* Is there code in other classes that directly manipulates this class's instance variables?
  * Looking at its accessible variables, I think so. 

DateMediator: 
* What is this class's responsibility?
  * DateMediator checks to see the level of conflict between two date ranges.  
* Is this class responsible for exactly one thing?
  * Yes. Although it can check for both hard conflicts and overlapping dates that are permissible between the check-out time and the check-in time.  
* Does this class take on any responsibility that should be delegated to "lower level" classes?
  * No, it might be the only true single-responsibility class in the entire program. 
* Is there code in other classes that directly manipulates this class's instance variables?
  * No, classes just call the methods within it, but almost all of its variables are accessible. 

Refactoring Ideas: 
  * Room Class: remove cost from attr_reader and rework the code to only access the class method of self.cost instead to remove redundancy. 
  * Reservation Class: examine what information needs to accessible from other classes and revisit attr_reader. 
  * Reservation Class: consider moving some of the functionality out of the initialize method. 
  * DateMediator Class: Guess what? look at attr_reader and what actually needs to be accessed from outside of it! I seriously think none of its attributes need to be readable from outside. 
  * Consider moving reservations and reserved blocks into Reservation Class out of Booker Class. The accompanying methods might have too much reach into instances of Reservation. 
  * Consider moving room_ids into Room Class out of Booker Class. Like when the instance of Room is created, move it over. 
  * Detangle Booker from other things. 

  Actual Refactoring Plan: 
    * Make the block_discount not a constant so that people reserving blocks can do it (this is to match the expectations in the project requirements)
    * Revisit Booker and delegate more into Reservation, Block and Room classes with specific regard to the following: 
        * Reservations array being moved into Reservations and adding a reservation into the collection as part of its initialize method 
        * Reserved blocks array being moved into Blocks and adding a block into the collection as part of its initialize method
        * Rooms array being moved into Rooms and adding a room upon population
            * This will have a component to limit the creation of new rooms to the HOTEL_CAPACITY constant but it can be reworked where this limit comes into being
        * Consider moving lists_reservations_for_range method and lists_available_rooms_for_range into Reservations and Rooms respectively since they'll have the reference of instances of themselves
        * Consider moving room_picker method into room also 