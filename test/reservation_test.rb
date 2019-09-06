require_relative 'test_helper'

describe Reservation do
 
 before do
  
  @new_hotel = Booker.new
  @test_reservation = Reservation.new(start_date: Date.today, end_date: Date.today+1, room_id: 1) 
  # @new_hotel.new_reservation
  
  # # creates a new instance of room
  # test_room_id = 1
  # @test_room = Room.new(id: test_room_id)
  # # creates a new instance of reservation using the pre-made room
  # test_start_date = Date.parse("2019/09/20")
  # test_end_date = Date.parse("2019/09/25")
  # @test_reservation_id = 0001
  
  # @test_reservation = Reservation.new(start_date: test_start_date, end_date: test_end_date, room_id: test_room_id, reservation_id: @test_reservation_id)
 end
 
 it "instance knows it's an instance of Reservation" do
  expect(@test_reservation).must_be_kind_of Reservation
 end
 
 it "instance of reservation start time and end time to be a kind of Date" do
  expect(@test_reservation.start_date).must_be_kind_of Date
  expect(@test_reservation.end_date).must_be_kind_of Date
 end
 
 it "instance of reservation knows the value of its start and end dates" do
  expected_start_date = Date.today
  expected_end_date = Date.today + 1
  expect(@test_reservation.start_date).must_be_close_to expected_start_date
  expect(@test_reservation.end_date).must_be_close_to expected_end_date
 end
 
 it "instance of reservation knows its associated room" do
  
  expect(@test_reservation.room_id).must_equal 1
  
 end
 
 it "instance of reservation knows its cost" do
  expect(@test_reservation.reservation_cost).must_equal 200
 end
 
 it "instance of reservation knows its reservation ID number" do
  expect(@test_reservation.reservation_id).must_equal @test_reservation_id
 end
 
 it "instance of reservation has nil for block label because Wave 1 problems" do
  expect(@test_reservation.block_label).must_be_nil
 end
 
 it "verifies that the dates in reservations are a kind of date" do
 end
 
end
