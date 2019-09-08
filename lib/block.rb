
require_relative 'room'

class Block 
 
 attr_reader :start_date, :end_date, :discount, :block_label, :room_id
 
 def initialize(start_date:, end_date:, discount:, block_label:, room_id: )
  
  @start_date = start_date
  @end_date = end_date
  
  if start_date.class != Date
   raise ArgumentError.new "dates must be instances of Date"
  end
  
  if end_date.class != Date
   raise ArgumentError.new "dates must be instances of Date"
  end
  
  @discount = discount
  
  @block_label = block_label
  
  @room_id = room_id
  
 end
 
end
