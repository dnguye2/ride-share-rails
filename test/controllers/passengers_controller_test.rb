require "test_helper"

describe PassengersController do
  before do
    @invalid_passenger_id = 989887763
  end

  describe "index" do
    it "responds with success when there are many passengers saved" do
      Passenger.create(name: 'Bojack', phone_num: '27')
      Passenger.create(name: 'Bean', phone_num: '3436')

      get "/passengers"

      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      get "/passengers"

      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @passenger = Passenger.create(name: 'Bojack', phone_num: '27')
    end


    it "responds with success when showing an existing valid passenger" do
      valid_passenger_id = @passenger.id

      get "/passengers/#{valid_passenger_id}"

      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      get "/passengers/#{@invalid_passenger_id}"

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:passenger_hash) {
      {
        passenger: {
          name: "Cookie Monster", 
          phone_num: "9999"
        }
      }
    }

    it "can create a new passenger with valid information accurately, and redirect" do
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1

      must_redirect_to root_path
      expect(Passenger.last.name).must_equal passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end

    it "does not create a passenger if the form if the form has invalid name, and responds with a redirect" do
      no_name = passenger_hash[:passenger][:name] = nil

      expect {
        post passengers_path, params: no_name
      }.must_differ 'Passenger.count', 0

      must_respond_with  :redirect
      must_redirect_to new_passenger_path
    end

    it "does not create a passenger if the form has no phone number, and responds with a redirect" do
      no_phone_num = passenger_hash[:passenger][:phone_num] = nil

      expect {
        post passengers_path, params: no_phone_num
      }.must_differ 'Passenger.count', 0

      must_respond_with  :redirect
      must_redirect_to new_passenger_path
    end
  end

  describe "edit" do
    before do
      @passenger = Passenger.create(name: 'Bojack', phone_num: '27')
    end

    it "responds with success when getting the edit page for an existing, valid passenger" do
      valid_passenger_id = @passenger.id
      
      get "/passengers/#{valid_passenger_id}/edit"

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get "/passengers/#{@invalid_passenger_id}/edit"

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    let (:new_passenger_hash) {
      {
        passenger: {
          name: "Warren", 
          phone_num: "99898"
        }
      }
    }

    before do
      @passenger = Passenger.create(name: 'Mr. Peanutbutter', phone_num: '22342')
      @passenger_id = @passenger.id
    end

    it "can update an existing passenger with valid information accurately, and redirect" do
      editted_params = {
        passenger: {
          name: "Mr. Peanutbutter",
          phone_num: "65463"
        }
      }

      expect { patch passenger_path(@passenger_id), params: editted_params}.wont_change Passenger.count
      must_respond_with :redirect

      expect(Passenger.find_by(id: @passenger_id).name).must_equal editted_params[:passenger][:name]
      expect(Passenger.find_by(id: @passenger_id).phone_num).must_equal editted_params[:passenger][:phone_num]
    end


    it "does not update any passenger if given an invalid id, and responds with a 404" do
      id = -1

      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change Passenger.count

      must_respond_with :not_found
    end

    it "does not update a passenger if the form data violates Passenger validations, and responds with a redirect" do
      new_passenger_hash[:passenger][:name] = nil
      passenger = Passenger.first

      expect {
        patch passenger_path(passenger.id), params: new_passenger_hash
      }.wont_change Passenger.count

      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      passenger = Passenger.create(name: 'Bojack', phone_num: '27')
      valid_passenger_id = passenger.id

      expect {
        delete passenger_path(valid_passenger_id)
      }.must_differ 'Passenger.count', -1

      must_respond_with :redirect
    end

    it "does not change the db when the passenger does not exist, then responds with redirect" do
      expect {
        delete passenger_path(@invalid_passenger_id)
      }.wont_change Passenger.count

      must_respond_with :redirect
    end
  end
end
