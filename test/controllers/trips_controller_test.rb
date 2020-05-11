require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # valid_driver_id = @driver.id

      # get "/drivers/#{valid_driver_id}"
      # must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      # invalid_driver_id = "989887763d"

      # get "/drivers/#{invalid_driver_id}"

      # must_respond_with :not_found
    end

    it "has a link to the detail page for the trip's passenger" do
      # responds with success when showing passenger's page, 200
    end

    it "has a link to the detail page for the trip's driver" do
      # responds with success when showing driver's page, 200
    end

  end

  describe "create" do

    it "assigns a driver that is available" do
      
    end

    it "can create a trip for a passenger and redirects to the newly created trip" do
      
    end

  end

  describe "edit" do
    it "can add a rating" do
      
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
