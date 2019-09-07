require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'reporter'

class Booker
 
 attr_accessor :rooms, :reservations
 
 def initialize 
  @rooms = populate_hotel
  @reservations = []
 end
 
 def populate_hotel
  rooms_array = []
  i = 1
  until i == 21 do 
   rooms_array << Room.new(id: i)
   i = i + 1
  end
  return rooms_array
 end  
 
 def new_reservation(start_date: Date.today, end_date: Date.today+1)
  if start_date.class != Date
   start_date = Date.parse("#{start_date}")
  end
  if end_date.class != Date
   end_date = Date.parse("#{end_date}")
  end
  reservation_id = reservations.length + 1
  reservations << Reservation.new(start_date: start_date, end_date: end_date, room_id: rooms.sample, reservation_id: reservation_id)
 end
 
 def list_room_ids
  room_id_list = []
  @rooms.each do |room|
   room_id_list << room.id
  end
  return room_id_list
 end
 
 def list_reservations_for_range(range_start:, range_end: )
  reservations_in_range = []
  range_start = Date.parse(range_start)
  range_end = Date.parse(range_end)
  
  @reservations.each do |reservation|
   start_date = reservation.start_date 
   end_date = reservation.end_date
   if DateMediator.new(range_start: range_start, range_end: range_end, start_date: start_date, end_date: end_date).main_function > 0
    reservations_in_range << reservation
   end
  end
  return reservations_in_range
  
 end
 
end