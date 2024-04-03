class AddUserIdToSwipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :swipes, :user, null: false, foreign_key: true
  end
end
