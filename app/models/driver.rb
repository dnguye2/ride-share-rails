class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true, format: {with: /[a-zA-Z]/} 
  validates :vin, presence: true
end
