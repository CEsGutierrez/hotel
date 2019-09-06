require "date"

class DateMediator
 
 attr_reader :range_start, :range_end, :start_date, :end_date 
 
 def initialize(range_start:, range_end:, start_date:, end_date:)
  
  # Checks that the dates being checked are in the appropriate format
  # The range_start and range_end come from previous reservations and had better not be anything other than instances of time
  @range_start = range_start
  @range_end = range_end
  @start_date = start_date
  @end_date = end_date
  
  
  if (start_date.class != Date || end_date.class != Date)
   raise ArgumentError.new "start and end dates are not instances of date"
  end
 end
 
 def main_function
  conflict_statement = 0
  check_start = start_date
  
  # this measures the conflicts created by the new dates against the already booked range 
  while check_start <= end_date do
   if check_start.between?(range_start, range_end)
    conflict_statement += 1 
    check_start += 1
   else
    
    check_start += 1
   end
  end
  
  # this erases the conflict created by dates that are touching the range but not actually treading upon it
  if conflict_statement == 1 && (@end_date == range_start || @start_date == range_end)
   conflict_statement = 0
  end
  
  
  return conflict_statement
  
 end
 
end