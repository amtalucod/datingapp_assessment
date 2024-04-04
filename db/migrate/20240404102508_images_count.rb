class ImagesCount < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :photo_count, :integer
  end
end
