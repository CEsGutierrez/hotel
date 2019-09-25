class Room
 
 attr_reader :id, :cost
 
 BASE_ROOM_COST = 200
 
 def initialize(id: nil)
  @id = id
  
  if @id == nil
   raise ArgumentError.new("No ID number provided")
  end
  @cost = Room.cost 
 end

 def self.cost 
  return BASE_ROOM_COST
 end
 
end
