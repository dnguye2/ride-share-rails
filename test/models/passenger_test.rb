require "test_helper"

describe Passenger do
  before do
    test_case_1 = Passenger.new(name: 'forrest', vin: '24')
  end

  it "must have a name" do
    new_passenger = Passenger.create(name: nil, phone_num: "4257619410")

    expect (new_passenger.valid?).must_equal false
  end

  it "must have a phone number" do 
    new_passenger = Passenger.create(name: "X Æ A-12", phone_num: nil)

    expect (new_passenger.valid?).must_equal false
  end
end
