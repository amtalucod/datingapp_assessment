class RemoveImages < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :images, :string
  end
end
