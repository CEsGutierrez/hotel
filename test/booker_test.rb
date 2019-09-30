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
 
 it "verifies that the desired start date for a reservation is before the end date" do
  expect{@booker.new_reservation(start_date: Date.today+1, end_date: Date.today)}.must_raise ArgumentError
 end
 
 describe "Booker's reporting abilities" do
  before do
   @new_hotel = Booker.new
   @test_reservation = @new_hotel.new_reservation
  end 
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

describe "booker conflicts with blocks" do
 before do
  @new_hotel = Booker.new
 end
 
 it "booker raises an argumenterror if the number of rooms requested exceeds the number of rooms available in the hotel" do
  # fills up the hotel with blocks to exceed capacity
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  
  19.times do
   @new_hotel.new_reservation(start_date: @test_start_date, end_date: @test_end_date)
  end
  
  @test_rooms_requested = 4
  
  expect{
   @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date , number_of_rooms: @test_rooms_requested)
  }.must_raise ArgumentError
 end
 
 it "booker raises an argumenterror if the dates passed into it for the creation of the new block have an invalid date range" do
  @test_start_date = Date.parse("2019-09-07")
  @test_end_date = Date.parse("2019-09-03")
  @test_rooms_requested = 4
  expect{
   @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date , number_of_rooms: @test_rooms_requested)
  }.must_raise ArgumentError
 end
 
 it "booker defaults to Today as the start date for a block and tomorrow as the end date for a block" do
  @test_rooms_requested = 4
  @test_block = @new_hotel.new_block(number_of_rooms: @test_rooms_requested)
  
  expect(@new_hotel.reserved_blocks[0].start_date).must_equal Date.today
  expect(@new_hotel.reserved_blocks[0].end_date).must_equal Date.today + 1
 end
 
 it "booker defaults to 2 rooms for the minimum of a block" do
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  
  @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date)
  expect(@new_hotel.reserved_blocks[0].number_of_rooms).must_equal 2
 end
 
 it "booker throws an argument error if the number of rooms requested for a block is more than 5" do
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  @test_rooms_requested = 6
  
  expect{
   @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date , number_of_rooms: @test_rooms_requested)
  }.must_raise ArgumentError
 end
 
 it "booker knows the block discount rate" do
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  @test_rooms_requested = 4
  
  @test_block = @new_hotel.new_block(start_date: @test_start_date, end_date: @test_end_date, number_of_rooms: @test_rooms_requested)
  
  expected_discount = 15
  
  expect(@new_hotel.reserved_blocks[0].discount).must_equal expected_discount
 end
 
 # it "instance of block knows its discount rate" do
 #  expected_discount = Block.discount
 #  expect(@test_block.discount).must_equal 
 # end
 
end

describe "booker creating new blocks and interactions with reservations" do
 before do
  @new_hotel = Booker.new
  5.times do
   @test_reservations = @new_hotel.new_reservation
  end
 end
 
 it "booker creates block_holders and adds them into reservations to work as blocks against booking over the block" do
  # by default, adds 2 new reservations also for Today to Tomorrow
  @test_block = @new_hotel.new_block
  expect(@new_hotel.reservations.length).must_equal 7
 end
 
 it "booker treats blocked rooms as reserved, does not allow a reservation to be booked over them" do
  # fills up hotel with 5 previously made reservations, a new block of 2 placeholders, and 13 additional reservations
  @test_block = @new_hotel.new_block
  13.times do
   @test_reservations = @new_hotel.new_reservation
  end
  # verifies that the hotel will not allow additional reservations
  expect{@new_hotel.new_reservation}.must_raise ArgumentError
 end
 
 it "booker does not list blocked rooms as available for date range" do
  @test_block = @new_hotel.new_block
  expect(@new_hotel.lists_available_rooms_for_range(range_start: Date.today, range_end: Date.today + 1).length).must_equal 13
 end
 
 it "booker does not list blocked rooms as reservations for date range" do
  @test_block = @new_hotel.new_block
  expect(@new_hotel.lists_reservations_for_range(range_start: Date.today, range_end: Date.today + 1).length).must_equal 5
 end
 
 it "booker assigns block-label based on the historical number of blocks that have been booked in the hotel. Like whatever the maximum number was before it's that plus one. Numbers will not be recycled, they will just creep upward forever. " do
  @test_block = @new_hotel.new_block
  expect(@new_hotel.reserved_blocks[0].block_label).must_equal 1
  @another_test_block = @new_hotel.new_block
  expect(@new_hotel.reserved_blocks[1].block_label).must_equal 2
 end
 
 it "booker can convert block_holders into reservations" do
  @test_block = @new_hotel.new_block
  
  expected_block_label = 1
  
  reservations_based_on_test_block = []
  @new_hotel.reservations.each do |reservation|
   if reservation.block_label == expected_block_label && reservation.reservation_id != nil
    reservations_baseD_on_test_block << []
    puts reservation.reservation_id
   end
  end
  
  expect(reservations_based_on_test_block.length).must_equal 0
  
  #actually flipps the reservation
  new_reservation_from_block = @new_hotel.new_reservation_from_block(expected_block_label)
  
  post_reservations_based_on_test_block = []
  @new_hotel.reservations.each do |reservation|
   if reservation.block_label == expected_block_label && reservation.reservation_id != nil
    post_reservations_based_on_test_block << []
   end
  end
  
  expect(post_reservations_based_on_test_block.length).must_equal 1
  
 end
 
 it "when reservations are made from blocks, they retain the block's originally assigned rooms, start date, end date" do
 end
 
 it "when reservations are made from blocks, they include the discounted price" do
 end
 
 it "when reservations are made from blocks, the number of available rooms for that block is divinable" do
 end
 
end