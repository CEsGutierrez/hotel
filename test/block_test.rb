require_relative 'test_helper'

describe "basic block behaviors" do
 
 before do
  @new_hotel = Booker.new
  block_id = @new_hotel.reserved_blocks.max + 1
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  @test_requested_number_of_rooms = 4
  @test_discount_percentage = 15
  @test_block_label = 1
  
  @test_block = Block.new(start_date: @test_start_date, end_date: @test_end_date, discount: @test_discount_percentage , number_of_rooms: @test_requested_number_of_rooms, block_label: @test_block_label)
 end
 
 it "instance of block knows it's an instance of Block " do
  expect(@test_block).must_be_kind_of Block
 end
 
 it "instance of block start time and end time are a kind of date" do
  expect(@test_block.start_date).must_be_kind_of Date
  expect(@test_block.end_date).must_be_kind_of Date
 end
 
 it "instance of block knows the value of its start and end dates" do
  expected_start_date = @test_start_date
  expected_end_date = @test_end_date
  expect(@test_block.start_date).must_be_close_to expected_start_date
  expect(@test_block.end_date).must_be_close_to expected_end_date
 end
 
 it "instance of block knows its discount percentage" do
  expect(@test_block.discount).must_equal @test_discount_percentage
 end
 
 it "instance of block knows its block label" do
  expect(@test_block.block_label).must_equal @test_block_label
 end
 
end