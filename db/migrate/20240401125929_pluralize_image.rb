class PluralizeImage < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :image, :images
  end
end
