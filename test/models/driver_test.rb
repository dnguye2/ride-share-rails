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
    it "accurately calculates a driver's earnings" do
      @driver = Driver.create(name: "Margaret", vin: "123", active: false)
      
      @passenger = Passenger.create(name: "Eileen", phone_num: "23432")
      
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 300)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 200.25)
      
      expect(@driver.total_earnings).must_equal "596.24"
    end

    it "returns nil for rating if driver has no completed any trips" do
      @driver = Driver.create(name: "Margaret", vin: "123", active: false)
      
      @passenger = Passenger.create(name: "Eileen", phone_num: "23432")

      expect(@driver.average_rating).must_equal nil
    end

    it "accurately calculates a driver's average rating" do
      driver = Driver.create(name: "Margaret", vin: "123", active: false)
      
      @passenger = Passenger.create(name: "Eileen", phone_num: "23432")
      
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 300)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 200.25)
      
      expect(@driver.average_rating).must_equal "4.00"
    end
  end
end
