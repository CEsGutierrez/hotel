require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require 'date'
require_relative 'booker'

class Reporter
 
 def list_room_ids
  room_id_list = []
  @rooms.each do |room|
   room_id_list << room.list_room_id
  end
  return room_id_list
 end
 
 def lists_reservations_for_range(range_start: Date.today, range_end: Date.today)
  reservations_in_range = []
  digested_range_start = date_digester(range_start)
  digested_range_end = date_digester(range_end)
  @reservations.each do |reservation|
   start_date = reservation.start_date 
   end_date = reservation.end_date
   if DateMediator.new(range_start: digested_range_start, range_end: digested_range_end, start_date: start_date, end_date: end_date).main_function > 0 && reservation.reservation_id != nil
    reservations_in_range << reservation
   end
  end
  return reservations_in_range
 end
 
 def lists_available_rooms_for_range(range_start:, range_end: )
  available_rooms_in_range = list_room_ids
  booked_rooms = []
  digested_range_start = date_digester(range_start)
  digested_range_end = date_digester(range_end)
  @reservations.each do |reservation|
   start_date = reservation.start_date 
   end_date = reservation.end_date
   if DateMediator.new(range_start: digested_range_start, range_end: digested_range_end, start_date: start_date, end_date: end_date).conflicting_dates > 0
    booked_rooms << reservation.room_id
   end
  end
  booked_rooms.each do |room_number|
   available_rooms_in_range.delete(room_number)
  end
  return available_rooms_in_range  
 end
 
 
 def date_digester(date)
  if date.class != Date
   digested_date = Date.parse("#{date}")
  else
   digested_date = date
  end
  return digested_date
 end
 
end