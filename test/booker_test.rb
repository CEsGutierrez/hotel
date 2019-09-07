require_relative 'test_helper'

describe "Booker basic functions" do
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
 
 it "default date for all reservations is today" do
  default_date = Date.today
  expect(@booker.new_reservation[0].start_date).must_equal default_date
 end
 
 it "default end date for all reservations is tomorrow" do
  default_end_date = Date.today + 1
  expect(@booker.new_reservation[0].end_date).must_equal default_end_date
 end
 
 it "converts stringy dates for reservations into instances of date" do
  
  test_start_date = "2020-01-02"
  test_end_date = "2020-01-05"
  
  test_reservation = @booker.new_reservation(start_date: test_start_date, end_date: test_end_date)
  
  expect(test_reservation[0].end_date).must_equal Date.parse(test_end_date)
  
 end
 
 it "instigates instances of reservation" do
 end
end

describe "Booker's reporting abilities" do
 before do
  @new_hotel = Booker.new
  @test_reservation = @new_hotel.new_reservation
 end 
 it "can list all the rooms in the hotel by their ID number" do
  expect(@new_hotel.list_room_ids.length).must_equal 20
  expect(@new_hotel.list_room_ids.uniq).must_equal @new_hotel.list_room_ids
 end
 
 it "room_picker returns the first available room for a given period of time" do
  expect(@new_hotel.reservations[0].room_id.id).must_equal 1
 end
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
 
 it "can access rooms from reservation history" do
  expect(@new_hotel.reservations[3].reservation_id).must_equal 4
 end
 
 it "can list all reservations for a given period of time" do
  # creates 3 reservations for April 2020
  additional_reservations = 3
  start_date = "2020-04-01"
  end_date = "2020-04-10"
  additional_reservations.times do
   @another_test_reservation = @new_hotel.new_reservation(start_date: start_date, end_date: end_date)
  end
  
  # creates 3 reservations for May 2020
  additional_reservations = 3
  start_date = "2020-05-01"
  end_date = "2020-05-10"
  additional_reservations.times do
   @another_test_reservation = @new_hotel.new_reservation(start_date: start_date, end_date: end_date)
  end
  
  test_range_start = "2020-03-30"
  test_range_end = "2020-04-15"
  
  expect(@new_hotel.lists_reservations_for_range(range_start: test_range_start, range_end: test_range_end).length).must_equal 3
  expect(@new_hotel.lists_reservations_for_range(range_start: test_range_start, range_end: test_range_end)[0]).must_be_kind_of Reservation
 end
 
 it "can list all available rooms for a given period of time" do
  
  # creates 3 reservations for April 2020
  additional_reservations = 3
  start_date = "2020-04-01"
  end_date = "2020-04-10"
  additional_reservations.times do
   @another_test_reservation = @new_hotel.new_reservation(start_date: start_date, end_date: end_date)
  end
  
  # creates 3 reservations for May 2020
  additional_reservations = 3
  start_date = "2020-05-01"
  end_date = "2020-05-10"
  additional_reservations.times do
   @another_test_reservation = @new_hotel.new_reservation(start_date: start_date, end_date: end_date)
  end
  
  test_range_start = "2020-03-30"
  test_range_end = "2020-04-15"
  
  expect(@new_hotel.lists_available_rooms_for_range(range_start: test_range_start, range_end: test_range_end).length).must_equal 17
 end
 
 xit "can assemble a collection of all the reserved dates for a given room" do  
 end
 
 xdescribe "blocking abilities" do
  xit "booker can instigate instances of blocks" do #This is where I'm placeholding additional tests for later
  end
  
 end
 
end
