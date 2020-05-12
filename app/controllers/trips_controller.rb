class TripsController < ApplicationController

  def show 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end

  def create 
  
  end

  def edit 
    
  end

  def update 
    
  end

  def destroy 
    
  end
end
