require "test_helper"

describe Passenger do

  let (:new_passenger) {
    Passenger.new(name: "Finn the Human", phone_num: "234")
  }

  describe "validations" do
    it "must have a name" do
      new_passenger = Passenger.create(name: nil, phone_num: "4257619410")

      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a phone number" do 
      new_passenger = Passenger.create(name: "X Æ A-12", phone_num: nil)

      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many trips" do
      new_passenger.save
      passenger = Passenger.first

      expect(passenger.trips.count).must_be :>=, 0
      passenger.trips.each do |trip|
        expect(trip).must_be_instance_of trip
      end
    end
  end

  describe "calculates riders total expenses" do
    it "accurately calculates a rider's total expenses" do
      
    end
  end
end
