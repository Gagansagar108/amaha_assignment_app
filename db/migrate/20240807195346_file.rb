class File < ActiveRecord::Migration[7.0]
  def change
    create_table :files do |col|
      col.string :name 
      col.string :processed_status
      col.string :file_url
      col.timestamps
    end 
  end
end
