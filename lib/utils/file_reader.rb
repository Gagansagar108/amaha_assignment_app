module FileReader
    def self.get_text_file_data(file_url)
      require 'open-uri'
      file_data = []
      begin 
        URI.open(file_url) do |file|
          file.each_line do |line|
            line_data = JSON.parse(line)
            file_data.push(line_data)
          end
        end
      rescue 
        raise "File url is invalid: #{file_url}"
      end
      
      return file_data
    end
end
  