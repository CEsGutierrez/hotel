require_relative 'test_helper'

describe Reservation do
 
 before do
  
  @new_hotel = Booker.new
  
  reservation_id = @new_hotel.reservations.length + 1
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-04")
  
  @test_reservation = Reservation.new(start_date: @test_start_date , end_date: @test_end_date, room_id: 1, reservation_id: reservation_id) 
 end
 
 it "instance knows it's an instance of Reservation" do
  expect(@test_reservation).must_be_kind_of Reservation
 end
 
 it "instance of reservation start time and end time to be a kind of Date" do
  expect(@test_reservation.start_date).must_be_kind_of Date
  expect(@test_reservation.end_date).must_be_kind_of Date
 end
 
 it "instance of reservation knows the value of its start and end dates" do
  expected_start_date = @test_start_date
  expected_end_date = @test_end_date
  expect(@test_reservation.start_date).must_be_close_to expected_start_date
  expect(@test_reservation.end_date).must_be_close_to expected_end_date
 end
 
 it "instance of reservation knows its associated room" do  
  expect(@test_reservation.room_id).must_equal 1
 end
 
 it "instance of reservation knows its cost" do
  expected_reservation_cost = Room.cost * (@test_reservation.end_date - @test_reservation.start_date).to_i
  expect(@test_reservation.reservation_cost).must_equal expected_reservation_cost
 end
 
 it "instance of reservation knows its reservation ID number" do
  expect(@test_reservation.reservation_id).must_equal 1
 end
 
 it "instance of reservation has nil for block label because Wave 1 proble ms" do
  expect(@test_reservation.block_label).must_be_nil
 end
 
 it "verifies that the dates in reservations are a kind of date" do
  
  reservation_id = @new_hotel.reservations.length + 1
  stringy_start_date = "2020-01-05"
  stringy_end_date = "2020-01-10"
  expect{
   @another_test_reservation = Reservation.new(start_date: stringy_start_date, end_date: stringy_end_date, room_id: 1, reservation_id: reservation_id) 
  }.must_raise ArgumentError
 end
 
 
end
