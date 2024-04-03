class AddLocationReferenceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :location, :bigint
  end
end
