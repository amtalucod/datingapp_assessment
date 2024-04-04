class RemoveForeignKeysLikeduser < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :swipes, column: "liked_user_id"
  end
end

