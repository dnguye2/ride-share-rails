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
      @driver = Driver.create!(
        name: 'Pops', 
        vin: '123',
        available: true
      )
      @passenger = Passenger.create!(
        name: 'Bojack', 
        phone_num: '27'
      )
    end


    let (:trip_hash) {
      {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id
        }
      }
    }
    it "assigns a driver that is available" do
      # expect {
      #   post trips_path, params: trip_hash
      # } 'Trip.driver.available', true
    end

    it "can create a trip for a passenger and redirects to the newly created trip" do
      expect {post trips_path}.must_differ "Trip.count", 1

      expect(Trip.last.passenger.id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      # must_redirect_to trip_path(Trip.id)
    end
  end

  describe "edit" do
    before do
      @driver = Driver.create(
        name: 'Spongebob', 
        vin: '123',
        available: true
      )
      @passenger = Passenger.create(
        name: 'Mrs. Puff', 
        phone_num: '8888888888'
      )

      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id)
    end

    it "can add a rating" do
      #if trip not in progress, rating != nil
      # in_progress_trip = Trip.new(updated_at: nil)
      # in_progress_trip.updated_at == nil
      
      # assert_not_nil(in_progress_trip.rating)
    end

    it "responds with success when getting the edit page for an existing, valid trip" do
        valid_trip_id = @trip.id
        
        get "/trips/#{valid_trip_id}/edit"

        must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      invalid_trip_id = 38921074938237438

      get "/passengers/#{invalid_trip_id}/edit"

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing trip with valid information accurately, and redirect" do
      # edited_params = {
      #   driver: {
      #     name: "Muscle Woman",
      #     vin: "34234"
      #   }
      # }

      # expect { patch driver_path(@driver_id), params: edited_params}.wont_change Trip.count
      # must_respond_with :redirect

      # expect(Trip.find_by(id: @trip_id).name).must_equal edited_params[:trip][:passenger_id]

    end
  end

  describe "destroy" do
    before do
      @driver = Driver.create(
        name: 'Spongebob', 
        vin: '123',
        available: true
      )
      @passenger = Passenger.create(
        name: 'Mrs. Puff', 
        phone_num: '8888888888'
      )

      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id)
    end

    it "destroys the trip instance in db when trip exists, then redirects" do
      valid_trip_id = @trip.id

      expect {
        delete trip_path(valid_trip_id)
      }.must_differ 'Trip.count', -1

       must_respond_with :redirect
    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      invalid_trip_id = 38921074938237438

      expect {
        delete passenger_path(invalid_trip_id)
      }.wont_change Trip.count

      must_respond_with :redirect
    end
   
  end
end
