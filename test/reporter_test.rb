

describe "Booker's reporting abilities" do
 before do
  @new_hotel = Booker.new
  @test_reservation = @new_hotel.new_reservation
 end 
 it "can list all the rooms in the hotel by their ID number" do
  expect(@new_hotel.list_room_ids.length).must_equal 20
  expect(@new_hotel.list_room_ids.uniq).must_equal @new_hotel.list_room_ids
 end
end