 require 'rails_helper'

 RSpec.describe 'request', type: :request do
  describe 'GET /customers/get_nearest_customers' do
    it 'fetch data' do
      get('/customers/get_nearest_customers')
      binding.pry
    end
  end
 end
