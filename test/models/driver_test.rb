require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Jake the Dog", vin: "234", available: true)
  }
  
  it "can be instantiated" do
    expect(new_driver.valid?).must_equal true
  end

  it "will have all required fields" do
    new_driver.save
    driver = Driver.first

    [:name, :vin, :available]. each do |field|
      expect(driver).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a name" do
      new_driver = Driver.create(name: nil, vin: "234023F")

      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a vin" do 
      new_driver = Driver.create(name: "X Æ A-12", vin: nil)

      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many trips" do
      new_driver.save
      driver = Driver.first

      expect(driver.trips.count).must_be :>=, 0
      driver.trips.each do |trip|
        expect(trip).must_be_instance_of trip
      end
    end
  end

  describe "calculates driver earnings and ratings" do
    before do
      @driver = Driver.create(name: "Margaret", vin: "123", available: false)
      
      @passenger = Passenger.create(name: "Eileen", phone_num: "23432")
      
      trip_1 = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 2000)
      trip_2 = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 3000)
      trip_3 = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 1000)
      
      @trip_array =[trip_1, trip_2, trip_3]
    end
    it "accurately calculates a driver's earnings" do
      expect(Driver.earnings(@trip_array)).must_equal "44.04"
    end

    it "returns nil for rating if driver has not completed any trips" do
      trip_array_nil = nil
      expect(Driver.average_rating(trip_array_nil)).must_equal nil
    end

    it "accurately calculates a driver's average rating" do      
      expect(Driver.average_rating(@trip_array)).must_equal 4.0
    end
  end
end
