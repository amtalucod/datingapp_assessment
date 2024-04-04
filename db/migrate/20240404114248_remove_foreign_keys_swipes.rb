class RemoveForeignKeysSwipes < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :swipes, :users
  end
end
