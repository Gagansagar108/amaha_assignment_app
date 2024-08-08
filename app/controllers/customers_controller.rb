class CustomersController < ApplicationController    
    def get_nearest_customers
        params = get_params
        
        file_url = params[:file_url]
        
        file_data = get_file_data(file_url)
        
        result = filter_data(file_data)
        
        sort_result(result)
        
        render json: {"data": result, "count": result.count}
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
        file_data.each do |data|
            lat_x = data["latitude"].to_f
            long_x = data["longitude"].to_f
            distance = DistanceCalculator.get_Haversine_distance(lat_x, long_x, lat_y, long_y)
            result.push(data.slice('user_id', 'name')) 
        end
        result
    end 

    def sort_result(result)
        result.sort_by!{|res| res["user_id"]}
    end 
end 




