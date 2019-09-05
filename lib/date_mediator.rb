# class DateMediator
require "date"
def date_checker (range_start:, range_end:, start_date:, end_date:)
 range_start = Date.parse(range_start)
 range_end = Date.parse(range_end)
 start_date = Date.parse(start_date)
 end_date = Date.parse(end_date)
 
 conflict = nil
 begin_date = start_date
 
 while begin_date < end_date do
  if begin_date.between?(range_start, range_end)
   conflict = "True"
   puts begin_date
   begin_date += 1
  else
   puts "no conflict for #{begin_date}"
   begin_date += 1
  end
 end
end

# This code works. So at the moment, there's just a simple test to see if there is a date conflict or not. 
# I imagine that this will have to fit somewhere