require_relative 'test_helper'

describe 'block characteristics' do
 
 before do
  @new_hotel = Booker.new
  
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  @test_rooms_requested = 4
  @block_discount = 15
  @block_label = 1
  
  @test_block = Block.new(start_date: @test_start_date, end_date: @test_end_date, number_of_rooms: @test_rooms_requested, discount: @block_discount, block_label: @block_label)
 end
 
 it "instance of block knows it's an instance of Block" do
  expect(@test_block).must_be_kind_of Block
 end
 
 it "instance of block knows its start date and end date" do
  expect(@test_block.start_date).must_equal @test_start_date
  expect(@test_block.end_date).must_equal @test_end_date
 end
 
 it "instance of block knows how many rooms it's requiring" do
  expect(@test_block.number_of_rooms).must_equal @test_rooms_requested
 end
 
 it "instance of block knows its discount" do
  expect(@test_block.discount).must_equal @block_discount
 end
 
 it "instance of block knows its block label" do
  expect(@test_block.block_label).must_equal @block_label
 end
end

describe "irregularities in creating a block" do
 
 before do
  @new_hotel = Booker.new
  
  @test_start_date = Date.parse("2019-09-03")
  @test_end_date = Date.parse("2019-09-07")
  @test_rooms_requested = 4
  @block_discount = 15
  @block_label = 1
 end
 
 it "block throws ArgumentError if start and end dates are not instances of Date" do
  test_start_date = "2019-09-03"
  test_end_date = "2019-09-07"
  expect{
   @test_block = Block.new(start_date: test_start_date, end_date: test_end_date, number_of_rooms: @test_rooms_requested, discount: @block_discount, block_label: @block_label)
  }.must_raise ArgumentError
 end
end