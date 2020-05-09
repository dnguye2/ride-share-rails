class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passengers_param)
    if @passenger.save
      redirect_to passengers_path # send them to /books path
    else
      render :new, :bad_request
    end
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
