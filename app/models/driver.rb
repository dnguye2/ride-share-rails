class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true, format: {with: /[a-zA-Z]/} 
  validates :vin, presence: true

  def earnings
    driver_trips = self.trips
    earnings = 0

    driver_trips.each do |trip|
      fee = trip.cost - 1.65
      trip_earnings = fee * 0.8
      earnings += trip_earnings
    end

    return earnings.round(2)
  end
  
  def average_rating
    driver_trips = self.trips
    in_progress_trips = 0
    all_ratings = 0
    
    return nil if driver_trips.empty?

    driver_trips.each do |trip|
      if trip.rating.nil?
        in_progress_trips += 1
      else
        all_ratings += trip.rating
      end
    end

    average = all_ratings/(driver_trips.length - in_progress_trips)

    return average
  end
end
