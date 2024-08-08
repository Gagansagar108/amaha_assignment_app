class CustomersController < ApplicationController
    url = 'https://cogoport-testing.sgp1.digitaloceanspaces.com/952beeb0b5eb6e485a5856ed84ca07c0/customers_file.txt'
    
    
    def get_nearest_customers
        params = get_params
        
        file_url = params[:file_url]
        
        file_data = get_file_data(file_url)
        
        res = filter_data(file_data)
        
        render json: res
    end 

    private
    
    def get_params
        params.require(:file_url)
        
        params.as_json.to_h.deep_symbolize_keys
    end

    def get_file_data(file_url)
        FileReader.get_text_file_data(file_url)
    end 

    def filter_data(file_data)
        result = []
        lat_y = DistanceConstants::OFFICE_LAT
        long_y = DistanceConstants::OFFICE_LONG
        binding.pry
        file_data.each do |data|
            lat_x = data["latitude"].to_f
            long_x = data["longitude"].to_f
            distance = DistanceCalculator.get_Haversine_distance(lat_x, long_x, lat_y, long_y)
            result.push(data) if distance <= 100
        end
        result
    end 
end 




