# lib/file_reader.rb

module FileReader
    def self.get_text_file_data(file_url)
      require 'open-uri'
      binding.pry
      begin 
        data = URI.open(file_url).read
      rescue 
        raise "File url is invalid: #{file_url}"
      end
      
      return JSON.parse(data)
    end
end
  