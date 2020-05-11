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

    it "has access to a link that shows all trips for that driver" do
      valid_trip_id = @trip.id

      get "/trips/#{valid_trip_id}/driver"

      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:driver) {
      {
        driver: {
          name: 'High-Five Ghost', 
          vin: '3123'
        }
      }
    }

    it "can create a new driver with valid information accurately, and redirect" do
      expect {
        post drivers_path, params: driver
      }.must_differ 'Driver.count', 1
   
      must_redirect_to root_path
      expect(Driver.last.name).must_equal driver[:driver][:name]
      expect(Driver.last.vin).must_equal driver[:driver][:vin]

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      nameless = driver[:driver][:name] = nil
      vinless = driver[:driver][:vin] = nil 

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
    before do
      @driver = Driver.create(name: 'Muscle Man', vin: '2343')
      @driver_id = @driver.id
    end

    it "can update an existing driver with valid information accurately, and redirect" do
      editted_params = {
        driver: {
          name: "Muscle Woman",
          vin: "34234"
        }
      }

      expect { patch driver_path(@driver_id), params: editted_params}.wont_change Driver.count
      must_respond_with :redirect

      expect(Driver.find_by(id: @driver_id).name).must_equal editted_params[:driver][:name]
      expect(Driver.find_by(id: @driver_id).vin).must_equal editted_params[:driver][:vin]
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      invalid_driver_id = -23
      
      assert_nil(Driver.find_by(id: invalid_driver_id))
      editted_params = {
        driver: {
          name: "Muscle Woman",
          vin: "34234"
        }
      }

      expect{ patch driver_path(invalid_driver_id), params: editted_params}.wont_change Driver.count
      assert_response :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      invalid_driver_params = [
        {
          driver: {
            name: "Skips",
            vin: ""
          },
          driver: {
            name: "",
            vin: "40404"
          }
        }
      ]

      invalid_driver_params.each do |i|
        expect{ patch driver_path(@driver_id), params: i }.must_differ "Driver.count", 0
      end

      must_respond_with :success
    end
  end

  describe "destroy" do
    before do
      @driver = Driver.create(name: "Eileen", vin: "444999")
    end

    it "destroys the driver instance in db when driver exists, then redirects" do
      expect { delete driver_path(@driver.id) }.must_differ "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      expect{ delete driver_path(-1) }.wont_change "Driver.count"

      must_respond_with :redirect
    end
  end

  describe "toggle_available" do
    it "changes a drivers status to unavailable (false) when assigned a trip" do

    end
  end
end
