require "test_helper"

describe DriversController do

  describe "index" do
    it "responds with success when there are many drivers saved" do
      Driver.create(name: 'Mordecai', vin: '227')
      Driver.create(name: 'Rigby', vin: '243')

      get "/drivers"
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      get "/drivers"
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @driver = Driver.create(name: 'Mordecai', vin: '261')
    end

    it "responds with success when showing an existing valid driver" do
      valid_driver_id = @driver.id

      get "/drivers/#{valid_driver_id}"
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      invalid_driver_id = "989887763d"

      get "/drivers/#{invalid_driver_id}"

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:driver_hash) {
      {
        driver: {
          name: 'High-Five Ghost', 
          vin: '3123'
        }
      }
    }

    it "can create a new driver with valid information accurately, and redirect" do
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1
   
      must_redirect_to root_path
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      nameless = driver_hash[:driver][:name] = nil
      vinless = driver_hash[:driver][:vin] = nil 

      expect { post drivers_path, params: nameless }.must_differ 'Driver.count', 0

      expect { post drivers_path, params: vinless }.must_differ 'Driver.count', 0
    end
  end
  
  describe "edit" do
    before do
      @driver = Driver.create(name: 'Pops', vin: '123')
    end

    it "responds with success when getting the edit page for an existing, valid driver" do
     valid_driver_id = @driver.id

     get "/drivers/#{valid_driver_id}/edit"
     must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      invalid_driver_id = "123kjdf"

      get "/drivers/#{invalid_driver_id}/edit"
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    let (:new_passenger_hash) {
      {
        passenger: {
          name: "Muscle Man", 
          phone_num: "4235"
        }
      }
    }
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count

      # Assert
      # Check that the controller redirects

    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end
