module Rack
    class Attack  
      throttle('upload_invitation_file', limit: 3, period: 5.minutes) do |request| 
        binding.pry
        request.params.deep_symbolize_keys[:request_ip] if request.path.ends_with?('get_freight_trend') 
      end

      throttle('get_nearest_customers', limit: 3, period: 5.minutes) do |request|
        request.params.deep_symbolize_keys[:request_ip] if request.path.ends_with?('get_freight_trend')
      end
    end   
end 
