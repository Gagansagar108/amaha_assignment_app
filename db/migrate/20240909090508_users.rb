class Users < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |col|
      col.string :name
      col.string :email
      col.timestamps
    end
  end
end
