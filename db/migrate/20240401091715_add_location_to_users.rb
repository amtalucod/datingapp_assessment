class AddLocationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :country, :string
    add_column :users, :state_region, :string
    add_column :users, :city, :string
   
  end
end
