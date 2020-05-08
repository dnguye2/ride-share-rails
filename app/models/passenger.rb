class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def expenses
    passenger_trips = self.trips
    total_spent = 0

    return nil if passenger_trips.nil?

    passenger_trips.each do |trip|
      total_spent += trip.cost
    end

    return total_spent
  end
end
