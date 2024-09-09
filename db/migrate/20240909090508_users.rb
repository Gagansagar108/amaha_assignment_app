class Users < ActiveRecord::Migration[7.0]
  def change
    create_table :user_rspecs do |col|
      col.string :name
      col.string :email
      col.timestamps
    end
  end
end
