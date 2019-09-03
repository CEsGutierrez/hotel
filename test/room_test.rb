require_relative 'test_helper'

describe Room do
 before do
  test_room_id = 5
  test_room_basic_cost = 200
  @test_room = Room.new(id: test_room_id, cost: test_room_basic_cost)
  
 end
 it "room is of appropriate class" do
  expect(@test_room).must_be_kind_of Room
 end
 
 it "instance of room knows its ID #" do
  expect(@test_room.id).must_equal 5
 end
 
 it "instance of room knows its basic cost" do
  expect (@test_room.cost).must_equal 200
 end
end

describe "Room initiation" do
 it "verifies that the basic room rate for each room is $200" do
  test_room_id = 5
  @test_room = Room.new(id: test_room_id)
  expect(@test_room.cost).must_equal 200
 end
 
 it "verifies that an ArgumentError is thrown if no room ID is used to instigate the instance of Room "do
  begin
  @test_room = Room.new
  expect(@test_room.id).must_be_nil
  rescue ArgumentError
  end
 end
 
end