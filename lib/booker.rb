require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_mediator'
require_relative 'block'
require_relative 'reporter'


class Booker
 
 attr_reader :HOTEL_CAPACITY
 
 attr_accessor :rooms, :reservations, :reserved_blocks
 
 HOTEL_CAPACITY = 20
 
 def initialize 
  @rooms = populate_hotel
  @reservations = []
  @reserved_blocks = []
 end
 
 def populate_hotel
  rooms_array = []
  i = 1
  while i <= HOTEL_CAPACITY  do 
   rooms_array << Room.new(id: i)
   i = i + 1
  end
  return rooms_array
 end  
 
 
 def new_reservation(start_date: Date.today, end_date: Date.today + 1)
  
  digested_start_date = date_digester(start_date)
  digested_end_date = date_digester(end_date)
  
  date_validator(digested_start_date, digested_end_date)
  
  reservation_id = reservations.length + 1
  
  selected_room = room_picker(range_start: digested_start_date, range_end: digested_end_date)
  
  unless (1..HOTEL_CAPACITY).include? selected_room
   raise ArgumentError.new "no room assigned for this reservation"
  end
  
  reservations << Reservation.new(start_date: digested_start_date, end_date: digested_end_date, room_id: selected_room, reservation_id: reservation_id)
  
 end
 
 def new_block(start_date: Date.today, end_date: Date.today + 1 , number_of_rooms: 2, block_label: 1, block_discount: 15)
  
  digested_start_date = date_digester(start_date)
  digested_end_date = date_digester(end_date)
  
  date_validator(digested_start_date, digested_end_date)
  
  if number_of_rooms < 2 || number_of_rooms > 5
   raise ArgumentError.new "invalid number of rooms requested for block"
  end
  
  if lists_available_rooms_for_range(range_start: digested_start_date, range_end: digested_end_date).length < number_of_rooms
   raise ArgumentError.new "block exceeds hotel capacity"
  end
  
  block_label = block_labeler
  
  number_of_rooms.times do
   
   selected_room = room_picker(range_start: digested_start_date, range_end: digested_end_date)
   
   unless (1..HOTEL_CAPACITY).include? selected_room
    raise ArgumentError.new "no room assigned for this reservation"
   end
   
   reservations << Reservation.new(start_date: digested_start_date, end_date: digested_end_date, room_id: selected_room, reservation_id: nil, block_label: block_label, block_discount: block_discount)
   
  end
  reserved_blocks << Block.new(start_date: start_date, end_date: end_date, discount: block_discount, block_label: block_label, number_of_rooms: number_of_rooms)
  
 end
 
 def new_reservation_from_block(block_label)
  
  reservations.each_with_index do |reservation, index|
   if reservation.block_label == block_label
    reservation.reservation_id = reservations[index] 
    break
   end
  end
  
  reserved_blocks.each do |block|
   if block_label == block.block_label
    block.number_of_rooms -= 1
   end
  end
  
 end
 
 def block_labeler
  block_labels = []
  @reserved_blocks.each do |block|
   block_labels << block.block_label
  end
  if !(block_labels.empty?)
   block_labels.uniq!
   return_statement = block_labels.max + 1
   return return_statement
  else
   return 1
  end
 end
 
 def date_digester(date)
  if date.class != Date
   digested_date = Date.parse("#{date}")
  else
   digested_date = date
  end
  return digested_date
 end
 
 def date_validator(first_date, second_date)
  # works with instances of date
  if first_date > second_date
   raise ArgumentError.new "Invalid date range"
  end
 end
 
 def room_picker(range_start: , range_end: )
  range_start = range_start
  range_end = range_end
  available_rooms = Reporter.lists_available_rooms_for_range(range_start: range_start, range_end: range_end)
  if available_rooms.length > 0
   return available_rooms[0]
  else
   return nil
  end
  
 end
 
 def self.hotel_capacity
  return HOTEL_CAPACITY
 end
 
end
