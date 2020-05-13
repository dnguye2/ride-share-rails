class PassengersController < ApplicationController
  def index
    @passengers = Passenger.page(params[:page]).per(25)
  end

  def show
    id = params[:id].to_i
    @passenger = Passenger.find(id)
    @trips = @passenger.trips
    @passenger_total_expenses = Passenger.expenses(@trips)

    if !@passenger.nil?
      @url = "http://thecatapi.com/api/images/get?format=src&type=gif&timestamp="
    end

    if @passenger.nil?
      head :not_found
      return
    end

  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passengers_param)
    if @passenger.save
      redirect_to root_path
    else
      render :new
    end

  rescue ActionController::ParameterMissing
    redirect_to new_passenger_path
  end
  

  def edit
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found 
      return
    elsif @passenger.update(passengers_param)
      redirect_to passengers_path
      return
    else 
      render :edit
      return
    end
  end

  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end

    @passenger.trips.each do |trip|
      trip.passenger = nil
    end

    @passenger.destroy

    redirect_to passengers_path
    return
  end

  
  private

  def passengers_param
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
