require "test_helper"

describe Driver do

  it "must have a name" do
    new_driver = Driver.create(name: nil, vin: "234023F")

    expect (new_driver.valid?).must_equal false
  end

  it "must have a phone number" do 
    new_driver = Driver.create(name: "X Æ A-12", vin: nil)

    expect (new_driver.valid?).must_equal false
  end
end
