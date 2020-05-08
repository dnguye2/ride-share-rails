require "test_helper"

describe PassengersController do
  describe "index" do
    it "shold get index" do
      get "/passengers"
      must_respond_with :success
    end

    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Passenger saved

      # Act

      # Assert

    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved

      # Act

      # Assert

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved

      # Act
      # get "/passengers/:id"

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger
      invalid_passenger_id = 989887763

      # Act
      get "passengers/#{invalid_passenger_id}"

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
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      # Act-Assert
      # Ensure that there is a change of 1 in Passenger.count

      # Assert
      # Find the newly created Passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user

    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved

      # Act

      # Assert

    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act

      # Assert

    end
  end

  describe "update" do
    it "can update an existing Passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing Passenger's id to a local variable
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates Passenger validations

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved

      # Act-Assert
      # Ensure that there is a change of -1 in Passenger.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act-Assert
      # Ensure that there is no change in Passenger.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end
