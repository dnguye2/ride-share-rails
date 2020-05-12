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
          passenger: @passenger.id
      }
    }

    it "can create a trip for a passenger and redirects to the newly created trip" do
      expect {post trips_path, params: trip_hash}.must_change "Trip.count", 1

      must_respond_with :redirect
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

      @driver2 = Driver.create(
        name: 'Squidward', 
        vin: '123',
        available: true
      )

      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id)
    end

    it "can update an existing trip with valid information accurately, and redirect" do
      edited_params = {
        trip: {
          driver_id: @driver2.id
        }
      }

      expect { patch trip_path(@trip.id), params: edited_params}.wont_change Trip.count
      must_respond_with :redirect

      expect(Trip.find_by(id: @trip.id).driver_id).must_equal edited_params[:trip][:driver_id]
    end

    it "rating is initially nil after a trip is created and can add a rating after a trip is created" do
      expect @trip.rating.must_equal nil

      edited_params = {
        trip: {
          rating: 4
        }
      }

      expect { patch trip_path(@trip.id), params: edited_params}.wont_change Trip.count

      expect(Trip.find_by(id: @trip.id).rating).must_equal edited_params[:trip][:rating]
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
