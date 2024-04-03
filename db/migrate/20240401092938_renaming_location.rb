class RenamingLocation < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :location, :location_id
  end
end
