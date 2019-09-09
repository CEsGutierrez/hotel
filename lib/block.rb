# require_relative 'room'

class Block 
 
 attr_accessor :number_of_rooms
 
 attr_reader :start_date, :end_date, :discount, :block_label
 
 def initialize(start_date:, end_date:, discount: , block_label: , number_of_rooms:)
  
  @start_date = start_date
  @end_date = end_date
  
  if start_date.class != Date || end_date.class != Date
   raise ArgumentError.new "dates must be instances of Date"
  end
  
  @discount = discount
  
  @block_label = block_label
  
  @number_of_rooms = number_of_rooms
  
 end
 
 
end
