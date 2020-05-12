class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  attribute :available, :boolean, default: -> {true}

  def self.earnings(trips)
    driver_trips = trips
    earnings = 0

    driver_trips.each do |trip|
      fee = trip.cost - 165
      trip_earnings = fee * 0.8
      earnings += trip_earnings
    end

    earnings = '%.2f' % (earnings.to_i/100.0)
    return earnings
  end
  

  def self.average_rating(trips)
    driver_trips = trips
    in_progress_trips = 0
    all_ratings = 0
    
    return nil if driver_trips == 0
    
    driver_trips.each do |trip|
      if trip.rating.nil?
        in_progress_trips += 1
      else
        all_ratings += trip.rating.to_f
      end
    end

    # return nil if (driver_trips.length - in_progress_trips = 0)
    average = (all_ratings/(driver_trips.length - in_progress_trips)).round(2)
    return average
  end

end
