class TripsController < ApplicationController

  def show 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end

  def new
    passenger_id = params[:passenger_id]
    
    @trip = Trip.new
    
    if passenger_id.nil?
      @passengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
  end

  def create 
    avail_driver = Trip.find_driver
    avail_driver_id = avail_driver.id
    passenger_id = params[:passenger]

    @trip = Trip.new(passenger_id: passenger_id, driver_id: avail_driver_id)

    if @trip.save
      @trip.driver.available = false
      @trip.driver.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passengers_path
      return
    end
  end

  def edit 
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update 
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    elsif @trip.update(trip_params)
      # @trip.update(rating: params[:trip][:rating])
      @trip.driver.available = false
      @trip.driver.save
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy 
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      return_to trips_path
      return
    else
      trip.destroy
      redirect_to root_path
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :cost, :rating, :driver_id, :passenger_id)
  end
end
