class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    id = params[:id].to_i
    @passenger = Passenger.find(id)

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
      redirect_to root_path # send them to /books path
    else
      render :new
    end

  rescue ActionController::ParameterMissing
    redirect_to new_passenger_path
  end
  

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end



  private

  def passengers_param
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
