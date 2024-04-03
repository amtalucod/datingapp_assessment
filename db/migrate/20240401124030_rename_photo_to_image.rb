class RenamePhotoToImage < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :photo, :image
  end
end
