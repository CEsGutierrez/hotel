require 'Time'
require_relative 'Room'
require_relative 'Reservation'
require_relative 'Reporter'

class Booker
 
 attr_accessor :rooms, :reservations
 
 
 @reservations = []
 
 def initialize 
  @rooms = populate_hotel
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
 
 
 
end