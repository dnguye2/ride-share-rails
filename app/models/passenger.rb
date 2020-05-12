class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def self.expenses(trips)
    passenger_trips = trips
    total_spent = 0

    return nil if passenger_trips.nil?

    passenger_trips.each do |trip|
      if trip.cost.nil?
        0
      else
        total_spent += trip.cost
      end
    end

    total_spent = '%.2f' % (total_spent.to_i/100.0)
    return total_spent
  end
end
