require_relative 'test_helper'

describe DateMediator do 
 
 it "raises and ArgumentError if you pass is dates that are not in Date format" do
  expect{
   DateMediator.new(range_start: 2014-11-01, range_end: 2014-11-10, start_date: "2019-10-10", end_date: "2019-10-11")
  }.must_raise ArgumentError
 end
 
 it "correctly asses that a date is not inside a given range" do
  range_start_date = Date.parse("2014-11-01")
  range_end_date = Date.parse("2014-11-10")
  start_date_being_tested = Date.parse("2014-10-25")
  end_date_being_tested = Date.parse("2014-10-28")
  
  @new_date_mediator = DateMediator.new(range_start: range_start_date, range_end: range_end_date, start_date: start_date_being_tested, end_date: end_date_being_tested)
  
  expect(@new_date_mediator.main_function).must_equal 0
 end
 
 it "correctly asses that a date is inside a given range" do
  range_start_date = Date.parse("2014-11-01")
  range_end_date = Date.parse("2014-11-10")
  start_date_being_tested = Date.parse("2014-10-25")
  end_date_being_tested = Date.parse("2014-11-03")
  
  @new_date_mediator = DateMediator.new(range_start: range_start_date, range_end: range_end_date, start_date: start_date_being_tested, end_date: end_date_being_tested)
  expect(@new_date_mediator.main_function).wont_equal 0
 end
 
 it "can determine if two date ranges are touching but NOT overalpping" do
  
  range_start_date = Date.parse("2014-11-01")
  range_end_date = Date.parse("2014-11-10")
  start_date_being_tested = Date.parse("2014-10-25")
  end_date_being_tested = Date.parse("2014-11-01")
  
  @new_date_mediator = DateMediator.new(range_start: range_start_date, range_end: range_end_date, start_date: start_date_being_tested, end_date: end_date_being_tested)
  expect(@new_date_mediator.main_function).must_equal 0
 end
 
end
