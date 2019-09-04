require_relative 'test_helper'

describe Booker do
 before do
  @booker = Booker.new
 end
 
 it "booker populates the hotel" do
  expect(@booker.rooms.length).must_equal 20
 end
 
 it "booker hotel population is made up of rooms" do
  arbitrary_test_room_id = 2
  expect(@booker.rooms[arbitrary_test_room_id]).must_be_kind_of Room
 end
 
 xit "booker can instigate instances of reservation" do 
 end
 
 xit "booker can instigate instances of blocks" do
 end
 
 
 
end

