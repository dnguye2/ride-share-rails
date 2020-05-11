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
end
