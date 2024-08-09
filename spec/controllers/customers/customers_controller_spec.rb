require 'rails_helper'

module Customers
  RSpec.describe CustomersController, type: :controller do
    describe "GET #get_nearest_customers" do
      let(:file_url) { 'https://amahastorage.s3.ap-south-1.amazonaws.com/2dqep81snzi1loo23itueiqnef52' }
      let(:params) do
        {
          file_url: file_url,
          office_lat: 19.0590317,
          office_long: 72.7553452,
          distance_range: 100
        }
      end
      let(:file_data) do
        [
          { "user_id" => 1, "name" => "Vivaan Sharma", "latitude" => -68.850431, "longitude" => -35.814792 },
          {"user_id"=> 101, "name"=> "Rudra Roy", "latitude"=> "19.0590317", "longitude"=> "72.7553452"}
        ]
      end

      let(:filtered_data) do
        [
          { "user_id" => 1, "name" => "John Doe" }
        ]
      end

      before do
        allow(FileReader).to receive(:get_text_file_data).with(file_url).and_return(file_data)
        allow(DistanceCalculator).to receive(:get_Haversine_distance).and_return(5) 
      end

      it "returns a successful response" do
        get :get_nearest_customers, params: params
        expect(response).to have_http_status(:success)
      end

      it "renders the correct JSON structure" do
        get :get_nearest_customers, params: params
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("data")
        expect(json_response).to have_key("count")
        expect(json_response["data"]).to eq(filtered_data)
      end

      it "calls FileReader.get_text_file_data with the correct file_url" do
        get :get_nearest_customers, params: params
        expect(FileReader).to have_received(:get_text_file_data).with(file_url)
      end

      it "filters and sorts the data correctly" do
        get :get_nearest_customers, params: params
        json_response = JSON.parse(response.body)
        expect(json_response["data"]).to eq(filtered_data)
      end
    end
  end
end
