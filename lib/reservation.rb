require 'Time'
require_relative 'Room'

class Reservation 
 
 attr_reader :start_date, :end_date, :room_id, :reservation_cost, :reservation_id, :block_label
 
 def initialize(start_date:, end_date:, room_id:, reservation_id: nil, block_label: nil)
  @start_date = start_date
  @end_date = end_date
  
  @room_id = room_id
  @reservation_id = reservation_id
  @block_label = block_label
  
  reservation_duration = end_date - start_date
  
  base_room_cost = Room.base_room_cost
  
  if block_label == nil
   @reservation_cost = reservation_duration * base_room_cost
  end
  
 end
end


