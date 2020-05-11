class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver


  attribute :date, :datetime, default: -> {Time.now}
  attribute :cost, :integer, default: -> {rand(1000..5000)}
  attribute :rating, :integer, default: -> {nil}

  def self.find_driver
    @drivers = Driver.all

    @drivers.each do |driver|
      return driver if driver.status == true
    end
  end

end

