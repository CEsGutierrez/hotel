class Room
 
 attr_reader :id, :cost, :BASE_ROOM_COST
 BASE_ROOM_COST = 200
 
 def initialize(id: nil)
  @id = id
  
  @cost = Room.base_room_cost
  if @id == nil
   raise ArgumentError.new("No ID number provided")
  end
 end
 
 def self.base_room_cost
  base_room_cost= BASE_ROOM_COST
  return base_room_cost
 end 
 
end