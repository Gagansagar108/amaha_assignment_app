 require 'rails_helper'
  #https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa
#customers/get_nearest_customers
 RSpec.describe 'request' do
  describe 'GET /customers/get_nearest_customers' do
    it 'fetch data' do
      get('/customers/get_nearest_customers')

      binding.pry
    end
  end
 end
