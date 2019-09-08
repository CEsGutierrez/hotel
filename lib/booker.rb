require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'reporter'
require_relative 'date_mediator'


class Booker
 
 attr_accessor :rooms, :reservations
 
 HOTEL_CAPACITY = 20
 
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
  
  selected_room = room_picker(range_start: start_date, range_end: end_date)
  
  unless (1..HOTEL_CAPACITY).include? selected_room
   raise ArgumentError.new "no room assigned for this reservation"
  end
  
  
  
  
  reservations << Reservation.new(start_date: start_date, end_date: end_date, room_id: selected_room, reservation_id: reservation_id)
 end
 
 def list_room_ids
  room_id_list = []
  @rooms.each do |room|
   room_id_list << room.id
  end
  return room_id_list
 end
 
 def lists_reservations_for_range(range_start: Date.today.to_s, range_end: Date.today+1.to_s )
  reservations_in_range = []
  if range_start.class != Date
   range_start = Date.parse(range_start)
  end
  if range_end.class!= Date
   range_end = Date.parse(range_end)
  end
  
  @reservations.each do |reservation|
   start_date = reservation.start_date 
   end_date = reservation.end_date
   if DateMediator.new(range_start: range_start, range_end: range_end, start_date: start_date, end_date: end_date).main_function > 0
    reservations_in_range << reservation
   end
  end
  return reservations_in_range
 end
 
 def lists_available_rooms_for_range(range_start:, range_end: )
  available_rooms_in_range = []
  booked_rooms = []
  if range_start.class != Date
   range_start = Date.parse(range_start)
  end
  if range_end.class != Date
   range_end = Date.parse(range_end)
  end
  
  @reservations.each do |reservation|
   start_date = reservation.start_date 
   end_date = reservation.end_date
   if DateMediator.new(range_start: range_start, range_end: range_end, start_date: start_date, end_date: end_date).conflicting_dates > 0
    booked_rooms << reservation.room_id
   end
  end
  available_rooms_in_range = list_room_ids
  booked_rooms.each do |room_number|
   available_rooms_in_range.delete(room_number)
  end
  return available_rooms_in_range  
 end
 
 def room_picker(range_start: , range_end: )
  range_start = range_start
  range_end = range_end
  available_rooms = lists_available_rooms_for_range(range_start: range_start, range_end: range_end)
  if available_rooms.length > 0
   return available_rooms[0]
  else
   return nil
  end
  
 end
end
