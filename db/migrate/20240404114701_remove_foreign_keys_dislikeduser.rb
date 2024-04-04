class RemoveForeignKeysDislikeduser < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :swipes, column: "disliked_user_id"
  end
end
