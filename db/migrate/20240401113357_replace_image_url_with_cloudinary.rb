class ReplaceImageUrlWithCloudinary < ActiveRecord::Migration[7.1]
  def change
    rename_column :images, :image_url, :cloudinary_url
  end
end
