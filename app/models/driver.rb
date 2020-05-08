class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true, format: {with: /[a-zA-Z]/} 
  validates :vin, presence: true

  def self.find_driver
    @drivers = Driver.all

    @drivers.each do |driver|
      return driver if driver.status == "available"
    end
  end
end
