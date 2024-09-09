 require 'rails_helper'
  #https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa
 Rspec.describe 'request' do

  it do
    get('/customers/get_nearest_customers')
    binding.pry
  end
 end
