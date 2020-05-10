require "test_helper"

describe PassengersController do
  before do
    @invalid_passenger_id = 989887763
  end

  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Ensure that there is at least one Passenger saved
      Passenger.create(name: 'Bojack', phone_num: '27')
      Passenger.create(name: 'Bean', phone_num: '3436')

      get "/passengers"

      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Ensure that there are zero passengers saved

      get "/passengers"

      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @passenger = Passenger.create(name: 'Bojack', phone_num: '27')
    end


    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      valid_passenger_id = @passenger.id

      # Act
      get "/passengers/#{valid_passenger_id}"

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger

      # Act
      get "/passengers/#{@invalid_passenger_id}"

      # Assert
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
      # Arrange
      # Set up the form data

      # Act-Assert
      # Ensure that there is a change of 1 in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1

      # Assert
      # Find the newly created Passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      must_redirect_to root_path
      expect(Passenger.last.name).must_equal passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end

    it "does not create a passenger if the form if the form has invalid name, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations
      no_name = passenger_hash[:passenger][:name] = nil

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        post passengers_path, params: no_name
      }.must_differ 'Passenger.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with  :redirect
      must_redirect_to new_passenger_path
    end

    it "does not create a passenger if the form has no phone number, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations
      no_phone_num = passenger_hash[:passenger][:phone_num] = nil

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        post passengers_path, params: no_phone_num
      }.must_differ 'Passenger.count', 0

      # Assert
      # Check that the controller redirects
      must_respond_with  :redirect
      must_redirect_to new_passenger_path
    end
  end

  describe "edit" do
    before do
      @passenger = Passenger.create(name: 'Bojack', phone_num: '27')
    end

    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      valid_passenger_id = @passenger.id
      
      # Act
      get "/passengers/#{valid_passenger_id}/edit"

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger - from before block at the top

      # Act
      get "/passengers/#{@invalid_passenger_id}/edit"

      # Assert
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
    it "can update an existing Passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing Passenger's id to a local variable
      # Set up the form data
      id = Passenger.first.id

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change Passenger.count

      must_respond_with :redirect

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
      passenger = Passenger.find_by(id: id)
      expect(Passenger.last.name).must_equal new_passenger_hash[:passenger][:name]
      expect(Passenger.last.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      id = -1

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change Passenger.count

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found

    end

    it "does not update a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates Passenger validations
      new_passenger_hash[:passenger][:name] = nil
      passenger = Passenger.first

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch passenger_path(passenger.id), params: new_passenger_hash
      }.wont_change Passenger.count

      # Assert
      # Check that the controller redirects
      passenger.reload # refresh the passenger from the database
      must_respond_with :redirect
      expect(passenger.name).wont_be_nil
    end
  end

  describe "destroy" do

    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger = Passenger.create(name: 'Bojack', phone_num: '27')
      valid_passenger_id = passenger.id

      # Act-Assert
      # Ensure that there is a change of -1 in Passenger.count
      expect {
        delete passenger_path(valid_passenger_id)
      }.must_differ 'Passenger.count', -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        delete passenger_path(@invalid_passenger_id)
      }.wont_change Passenger.count

      # Assert
      #TO DO
      #### Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
