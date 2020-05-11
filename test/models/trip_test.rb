require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create( 
      name: "Finn the Human", 
      phone_num: "234"
    )
    @driver = Driver.create(
      name: "Jake the Dog", 
      vin: "234", 
      available: true
    )
  end
  
  let (:new_trip) {
    Trip.new(
      date: Time.now, 
      cost: 74, 
      rating: 1, 
      driver_id: @driver.id, 
      passenger_id: @passenger.id
    )
  }
  describe "initialize" do

    it "can be instantiated" do
      expect(new_trip.valid?).must_equal true
    end

    it "has a driver and passenger" do
      assert_not_nil(new_trip.driver_id)
      assert_not_nil(new_trip.passenger_id)
    end
    
    it "has required fields" do
      new_trip.save
      trip = Trip.first

      [:date, :cost, :rating, :driver_id, :passenger_id].each do |field|
        expect(trip).must_respond_to field
      end
    end

    describe "relationships" do
      it "belongs to driver" do
        new_trip.save
        trip = Trip.first

        expect(trip.driver.valid?).must_equal true
        expect(trip.driver).must_be_instance_of Driver
      end

      it "belongs to passenger" do
        new_trip.save
        trip = Trip.first

        expect(trip.passenger.valid?).must_equal true
        expect(trip.passenger).must_be_instance_of Passenger
      end
    end
  end
end
