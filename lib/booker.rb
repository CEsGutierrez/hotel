require 'Time'
require_relative 'Room'
require_relative 'Reservation'
require_relative 'Reporter'

class Booker
 
 SECONDS_PER_DAY = 86400
 
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
 
 def new_reservation(start_date: Time.now, end_date: Time.now+SECONDS_PER_DAY)
  start_date = start_date
  end_date = end_date
  reservation_id = @reservations.length + 1
  reservations << Reservation.new(start_date: start_date, end_date: end_date, room_id: 2)
 end
 
 def list_room_ids
  room_id_list = []
  @rooms.each do |room|
   room_id_list << room.id
  end
  return room_id_list
 end
 
 def list_reservations_for_room(room_id)
  reservations_for_room = []
  @reservations.each do |reservation|
   if reservation.room_id == room_id
    reservations_for_room << reservation
   end
  end
  return reservations_for_room
 end
 
 
 
end