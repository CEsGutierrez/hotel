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
 
 it "verifies that the desired start date for a reservation is before the end date" do
  expect{@booker.new_reservation(start_date: Date.today+1, end_date: Date.today)}.must_raise ArgumentError
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
  expect(@new_hotel.reservations[0].room_id).must_equal 1
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
 
 it "room_picker returns the first available room without conflict for a given date" do
  room_number = 6
  room_index = room_number - 1
  expect(@new_hotel.reservations[room_index].room_id).must_equal room_number
  expect
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
 
 it "throws an ArgumentError when hotel runs out of rooms and blocks the additional instances of Reservations for that block of time" do
  # buys out the hotel, note without a date range all dates are defaulting to Date.today and Date.today + 1
  
  @new_hotel = Booker.new
  expect{200.times{@new_hotel.new_reservation}}.must_raise ArgumentError
  expect(@new_hotel.reservations.length).must_equal 20
  
 end
 
end

describe "registering a block" do
 
 # before do
 #  @test_start_date = Date.parse("2019-09-03")
 #  @test_end_date = Date.parse("2019-09-07")
 #  @test_room_number = 4
  
 #  @new_hotel = Booker.new
  
 #  @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date , number_of_rooms: @test_room_number)
  
 # end
 
 it "booker raises an argumenterror if the number of rooms requested exceeds the number of rooms available in the hotel" do
 end
 
 it "booker raises an argumenterror if the dates passed into it for the creation of the new block have an invalid date range" do
 end
 
 it "booker defaults to Today as the start date for a block" do
 end
 
 it "booker defaults to Tomorrow as the end date for a block" do
 end
 
 it "booker defaults to 2 rooms for the minimum of a block" do
 end
 
 it "booker throws an argument error if the number of rooms requested for a block is more than 5" do
 end
 
 it "booker adds the new blocks into reservations to avoid booking over them" do
 end
 
 
end