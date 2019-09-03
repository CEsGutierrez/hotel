class Room
 
 attr_reader :id, :cost
 
 BASE_ROOM_COST = 200
 
 def initialize(id: nil , cost: BASE_ROOM_COST)
  @id = id
  @cost = cost
  
  if @id == nil
   raise ArgumentError.new("No ID number provided")
  end
  
 end
 
 
end