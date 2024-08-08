class CustomersController < ApplicationController
    url = 'https://cogoport-testing.sgp1.digitaloceanspaces.com/952beeb0b5eb6e485a5856ed84ca07c0/customers_file.txt'
    
    
    def get_nearest_customers
        params = get_params
        file_url = params[:file_url]

        
        
        
    end 

    private
    
    def get_params
        params.require(:file_url)
        params.as_json.to_h.deep_symbolize_keys
        file_data = get_file_data(file_url)
        filter_data(filter_data)
    end

    def get_file_data(file_url)
        FileReader.get_text_file_data(file_url)
    end 

    def filter_data(file_data)
        result = []
        
        binding.pry
        file_data.each do |data|
            distance = DistanceCalculator.get_Haversine_distance()
        end
    end 
end 




