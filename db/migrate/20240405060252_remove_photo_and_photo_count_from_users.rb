class RemovePhotoAndPhotoCountFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :photos, :string
    remove_column :users, :photo_count, :integer
  end
end
