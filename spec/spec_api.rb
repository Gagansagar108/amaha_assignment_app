 require 'rails_helper'

 RSpec.describe 'request', type: :request do
  describe 'GET /customers/get_nearest_customers' do
    it 'fetch data' do
      get('/customers/get_nearest_customers', params: {file_url: 'https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa' })
      binding.pry
    end
  end
 end
