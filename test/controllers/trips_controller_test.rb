require "test_helper"

describe TripsController do
  describe "show" do
    before do
      @driver = Driver.create(
        name: 'Pops', 
        vin: '123',
        available: true
      )
      @passenger = Passenger.create(
        name: 'Bojack', 
        phone_num: '27'
      )
      @trip = Trip.create(
        driver_id: @driver.id,
        passenger_id: @passenger.id
      )
    end

    it "responds with success when showing an existing valid trip" do
      valid_trip_id = @trip.id

      get "/trips/#{valid_trip_id}"

      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      invalid_trip_id = "989887763d"

      get "/trips/#{invalid_trip_id}"

      must_respond_with :not_found
    end

    it "has a link to the detail page for the trip's passenger" do
      valid_passenger_id = @passenger.id

      get "/passengers/#{valid_passenger_id}"

      must_respond_with :success
    end

    it "has a link to the detail page for the trip's driver" do
      valid_driver_id = @driver.id

      get "/drivers/#{valid_driver_id}"

      must_respond_with :success
    end
  end

  describe "create" do
    before do
      @driver = Driver.create(
        name: 'Pops', 
        vin: '123',
      )
      @passenger = Passenger.create(
        name: 'Bojack', 
        phone_num: '27'
      )
    end

    let (:trip_hash) {
        {
          driver_id: @driver.id,
          passenger_id: @passenger.id
        }
      }

    it "assigns a driver that is available" do
      # expect(@trip.driver.available).must_equal true

      expect {
        post trips_path, params: trip_hash
      }.assert_not_equal 'Trip.driver.available', true

    end

    it "can create a trip for a passenger and redirects to the newly created trip" do
      expect {
        post trips_path, params: trip_hash
      }.must_change 'Trip.count', 1

      expect(Trip.last.passenger.id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trip_path(Trip.last.id)
    end
  end

  describe "edit" do
    it "can add a rating" do
      #if trip not in progress, rating != nil
      # in_progress_trip = Trip.new(updated_at: nil)
      # in_progress_trip.updated_at == nil
      
      # assert_not_nil(in_progress_trip.rating)
    end
  end

  describe "update" do
    it "can update an existing trip with valid information accurately, and redirect" do
      # editted_params = {
      #   driver: {
      #     name: "Muscle Woman",
      #     vin: "34234"
      #   }
      # }

      # expect { patch driver_path(@driver_id), params: editted_params}.wont_change Driver.count
      # must_respond_with :redirect

      # expect(Driver.find_by(id: @driver_id).name).must_equal editted_params[:driver][:name]
      # expect(Driver.find_by(id: @driver_id).vin).must_equal editted_params[:driver][:vin]
    end
  end

  describe "destroy" do
   it "can delete a trip and redirect" do
     
   end
   
   
  end
end
