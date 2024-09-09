class Users < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |col|
      col.string :name
      col.string :email
      coll.timestamps
    end
  end
end
