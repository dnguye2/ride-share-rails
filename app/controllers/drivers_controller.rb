class DriversController < ApplicationController
  def index 
    @drivers = Driver.page(params[:page]).per(25)
  end

  def show 
    id = params[:id].to_i
    @driver = Driver.find(id)
    @trips = @driver.trips
    @earnings = Driver.earnings(@trips)
    @average_rating = Driver.average_rating(@trips)

    if @driver.nil?
      head :not_found
      return
    end

    rescue ActiveRecord::RecordNotFound
      head :not_found
  end

  def new 
    @driver = Driver.new
  end

  def create 
    @driver = Driver.create(driver_params)
    if @driver.id?
      redirect_to root_path
    else
      render :new
    end

  rescue ActionController::ParameterMissing
    redirect_to new_driver_path
  end

  def edit 
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update 
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to drivers_path
      return
    else
      render :edit
      return
    end
  end

  def destroy 
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    elsif @driver.destroy
      redirect_to drivers_path
      return
    else
      render :index
      return
    end
  end

  def toggle_available
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path, status: :not_found
    else
      @driver.toggle!(:available)
      redirect_to driver_path(@driver.id)
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
