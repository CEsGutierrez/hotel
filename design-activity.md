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

* Adjusted code so that block_discount is no longer a constant but needs to be entered in at the time that a block reservation is being made. Default is 15% but is changeable. 

* When do classes take on multiple roles? 
  I think Booker takes on too many roles. I think it might be good to split its reporting methods from it's activity methods.

* Changes I think I need to make to improve the design: 
  * I want to make another class called BookingReporter that simply stores and reports back the information from reservations and bookings. 
  In detail: 
  * Move room_array, reservations, blocks and their respective reporting methods into that class
  * Adjust the tests to reflect the creation of this class
  * My concern is that this class and Booker might be too dependent on each other because Booker needs to access the stored reservations and blocks for several things. 
    