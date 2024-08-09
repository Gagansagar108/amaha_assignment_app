module Customers
    class CustomersController < ApplicationController    
    def get_nearest_customers
        params = get_params
        
        file_data = get_file_data(params)
        
        result = filter_data(file_data, params)
        
        sort_result(result)
        
        render json: {"data": result, "count": result.count}
    end 

    private
    
    def get_params
        params.require(:file_url)
        
        params.as_json.to_h.deep_symbolize_keys
    end

    def get_file_data(params)
        FileReader.get_text_file_data(params[:file_url])
    end 

    def filter_data(file_data,params)
        result = []
       
        lat_y = params[:office_lat] || DistanceConstants::OFFICE_LAT
        long_y = params[:office_long] || DistanceConstants::OFFICE_LONG
       
        file_data.each do |data|
            lat_x = data["latitude"].to_f
            long_x = data["longitude"].to_f
            distance = DistanceCalculator.get_Haversine_distance(lat_x, long_x, lat_y, long_y)
            result.push(data.slice('user_id', 'name')) if distance <= (params[:distance_range] || DistanceConstants::DISTANCE_RANGE).to_f
        end
        result
    end 

    def sort_result(result)
        result.sort_by!{|res| res["user_id"]}
    end 
end 




