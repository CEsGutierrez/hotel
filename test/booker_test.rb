require_relative 'test_helper'

describe Booker do
 before do
  @booker = Booker.new
 end
 
 it "populates the hotel" do
  expect(@booker.rooms.length).must_equal 20
 end
 
 it "hotel population is made up of rooms" do
  arbitrary_test_room_id = 2
  expect(@booker.rooms[arbitrary_test_room_id]).must_be_kind_of Room
 end
 
 it "hotel population is made up of unique rooms" do
  expect(@booker.rooms.uniq).must_equal @booker.rooms
 end
 
 it "can instigate instances of reservation" do
  arbitrary_test_reservation_position = 0
  expect(@booker.new_reservation[arbitrary_test_reservation_position]).must_be_kind_of Reservation
 end
 
 
end
describe "reporting abilities" do
 before do
  @new_hotel = Booker.new
  @test_reservation = @new_hotel.new_reservation
 end
 
 it "can list all the rooms in the hotel by their ID number" do
  
  expect(@new_hotel.list_room_ids.length).must_equal 20
  expect(@new_hotel.list_room_ids.uniq).must_equal @new_hotel.list_room_ids
  
 end
 describe "Booking multiple reservations" do
  before do
   @new_hotel = Booker.new
   @arbitrary_new_reservations = 6
   @arbitrary_new_reservations.times do
    @test_reservation = @new_hotel.new_reservation
   end
  end
  
  it "is compiling a list of reservations made" do
   expect(@new_hotel.reservations.length).must_equal @arbitrary_new_reservations
   expect(@new_hotel.reservations.uniq).must_equal @new_hotel.reservations
  end
  
  it "can access room-specific reservation history" do
   expect(@new_hotel.reservations[3].reservation_id).must_equal 3
  end
  
  it "can list all reservations for a given period of time" do
  end
  
 end
 
 xdescribe "blocking abilities" do
  xit "booker can instigate instances of blocks" do #This is where I'm placeholding additional tests for later
  end
  
 end
 
end