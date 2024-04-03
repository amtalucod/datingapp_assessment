class RemoveLocationFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :country, :string
    remove_column :users, :state_region, :string
    remove_column :users, :city, :string
  end
end
