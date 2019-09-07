
require_relative 'room'

class Reservation 
 
 attr_reader :start_date, :end_date, :room_id, :reservation_cost, :reservation_id, :block_label
 
 BLOCK_DISCOUNT = nil
 
 def initialize(start_date:, end_date:, room_id:, reservation_id: nil, block_label: nil)
  
  @start_date = start_date
  @end_date = end_date
  
  if start_date.class != Date
   raise ArgumentError.new "dates must be instances of Date"
  end
  if end_date.class != Date
   raise ArgumentError.new "dates must be instances of Date"
  end
  
  @room_id = room_id
  @reservation_id = reservation_id
  @block_label = block_label
  
  reservation_duration = (end_date - start_date).to_i
  
  room_cost = Room.cost * 1
  
  @reservation_cost = room_cost * reservation_duration
  
  if block_label != nil
   @reservation_cost = @reservation_cost * BLOCK_DISCOUNT
  end
  
  
  
  
 end
 
end


