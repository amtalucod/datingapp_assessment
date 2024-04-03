class ImageRename < ActiveRecord::Migration[7.1]
  def change
    rename_column :images, :image, :image_url
  end
end
