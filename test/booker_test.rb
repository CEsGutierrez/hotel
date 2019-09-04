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
 
 it "booker hotel population is made up of unique rooms" do
  expect(@booker.rooms.uniq).must_equal @booker.rooms
 end
 
 it "booker can instigate instances of reservation" do
  arbitrary_test_reservation_position = 0
  expect(@booker.new_reservation[arbitrary_test_reservation_position]).must_be_kind_of Reservation
 end
 
 
end
describe "reporting abilities" do
 before do
  @new_hotel = Booker.new
  @test_reservation = @new_hotel.new_reservation
 end
 
 it "reporter can list all the rooms in the hotel by their ID number" do
  room_ids = []
  @new_hotel.rooms.each do |room|
   room_ids << room.id
  end
  expect(room_ids.length).must_equal 20
  expect(room_ids.uniq).must_equal room_ids
 end
end

describe "blocking abilities" do
 
 xit "booker can instigate instances of blocks" do #This is where I'm placeholding additional tests for later
 end
 
end

