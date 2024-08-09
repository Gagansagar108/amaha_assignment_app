module DistanceCalculator
    def self.get_Haversine_distance(lat_x, long_x, lat_y, long_y)
        binding.pry
        unit_rad = Math::PI/180
        del_phi = (lat_y - lat_x)*unit_rad
        del_lambda = (long_y - long_x)*unit_rad
        cos_phi = Math.sqrt(
                ((1-Math.cos(del_phi)) + 
                        Math.cos(lat_x*unit_rad)*Math.cos(lat_y*unit_rad)*(1 - Math.cos(del_lambda))
                )/2
                )
        
        return 2*DistanceConstants::EARTH_RADIUS*Math.asin(cos_phi)
    end 
end 