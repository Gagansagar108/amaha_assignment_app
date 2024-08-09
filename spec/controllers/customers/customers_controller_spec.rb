require 'rails_helper'

RSpec.describe Customers::CustomersController, type: :controller do
  describe 'GET #get_nearest_customers' do
    let(:file_url) { 'https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa' }
    let(:valid_params) { { file_url: file_url, office_lat: '12.9716', office_long: '77.5946', distance_range: '50' } }
    let(:invalid_params) { { file_url: file_url, office_lat: 'invalid_lat', office_long: 'invalid_long' } }
    let(:file_data) do
      [
        { "user_id" => 1, "name" => "Vivaan Sharma", "latitude" => "-68.850431", "longitude" => "-35.814792" },
        { "user_id" => 2, "name" => "Aditya Singh", "latitude" => "82.784317", "longitude" => "-11.291294" },
        { "user_id" => 3, "name" => "Ayaan Reddy", "latitude" => "-35.328826", "longitude" => "134.432403" }
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
        expect(data.count).to eq(2)  # Adjust count based on expected results

        first_record = data.first
        expect(first_record).to include('user_id' => 1, 'name' => 'Vivaan Sharma')
        expect(data).to include('user_id' => 2, 'name' => 'Aditya Singh')
      end
    end

    context 'when parameters are invalid' do
      it 'returns an empty data array' do
        get :get_nearest_customers, params: invalid_params

        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key('data')
        expect(json_response).to have_key('count')

        data = json_response['data']
        expect(data).to be_an(Array)
        expect(data).to be_empty
      end
    end

    context 'when file URL is invalid' do
      before do
        allow(FileReader).to receive(:get_text_file_data).with(file_url).and_raise(StandardError.new('File not found'))
      end

      it 'handles errors gracefully and returns an empty data array' do
        get :get_nearest_customers, params: valid_params

        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key('data')
        expect(json_response).to have_key('count')

        data = json_response['data']
        expect(data).to be_an(Array)
        expect(data).to be_empty
      end
    end

    # Add more test cases as needed, such as for edge cases or different scenarios
  end
end
