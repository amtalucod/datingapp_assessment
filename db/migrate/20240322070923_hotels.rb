class Hotels < ActiveRecord::Migration[7.1]
  def up
    rename_column :hotels, :amenities_string, :amenities
  end
  
  def down
    rename_column :hotels, :amenities, :amenities_string
  end
end
