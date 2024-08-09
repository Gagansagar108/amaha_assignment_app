require 'rails_helper'

RSpec.describe Customers::CustomersController, type: :controller do
  describe 'GET #get_nearest_customers' do
    let(:file_url) { 'https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa' }
    let(:valid_params) { { "file_url": file_url, "office_lat": 19.0590317, "office_long": 72.7553452, "distance_range": 100 } }
    let(:distance_out_of_range) { { file_url: 'https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa', "office_lat": 19.0590317, "office_long": 72.7553452, "distance_range": 10 } }
    let(:invalid_file) { { file_url: 'https://dummy_amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa', "office_lat": 19.0590317, "office_long": 72.7553452, "distance_range": 10 } }
    let(:file_data) do
      [
        {"user_id": 1, "name": "Vivaan Sharma", "latitude": 19.850431, "longitude": 72.814792},
        {"user_id": 2, "name": "Aditya Singh", "latitude": 19.784317, "longitude": 72.291294},
        {"user_id": 3, "name": "Ayaan Reddy", "latitude": -35.328826, "longitude": 134.432403}
      ]
    end
    before do
      allow(FileReader).to receive(:get_text_file_data).with(file_url).and_return(file_data)
    end

    context 'when parameters are valid' do
      it 'returns the nearest customers as JSON' do
        
        get :get_nearest_customers, params: valid_params
        
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key('data')
        expect(json_response).to have_key('count')
        
        data = json_response['data']
        expect(data).to be_an(Array)
        expect(data.count).to eq(2) 

        first_record = data.first
        second_record = data.second
        
        expect(first_record).to include('user_id' => 1, 'name' => 'Vivaan Sharma')
        expect(second_record).to include("user_id" => 2, "name" =>  "Aditya Singh")
      end
    end

    context 'when distance is out of range' do
      it 'returns an empty data array and count zero' do
        get :get_nearest_customers, params: distance_out_of_range

        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key('data')
        expect(json_response).to have_key('count')
        data = json_response['data']
        expect(data).to be_an(Array)
        expect(data).to be_empty
        expect(data.count).to eq(0)
      end
    end

    context 'when parameters are missing' do

      before do
        allow(FileReader).to receive(:get_text_file_data).with(invalid_file).and_raise(StandardError, 'File not found')
      end

      it 'returns a 422 Unprocessable Entity status with an error message' do
        binding.pry
        get :get_nearest_customers, params: invalid_file
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("param is missing or the value is empty")
      end
    end

  end
end
