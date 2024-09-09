 require 'rails_helper'
  #https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa

 RSpec.describe 'request' do

    describe 'GET /customers/get_nearest_customers' do
    it 'get' do
      binding.pry
      get('/customers/get_nearest_customers')
    end
  end
 end
