class CustomersController < ApplicationController
    url = 'https://cogoport-testing.sgp1.digitaloceanspaces.com/952beeb0b5eb6e485a5856ed84ca07c0/customers_file.txt'
    
    
    def get_nearest_customers
        binding.pry
        data = get_params
        file_url = data.file_url

        file_data = get_file_data(file_url)
    end 

    private
    
    def get_params
        params.require(:file_url)
        params
    end

    def get_file_data(file_url)
        require 'open-uri'
        
        FileReader.get_text_file_data(file_url)
    end 

end 




